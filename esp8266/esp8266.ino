// LED
#define PIN_LED_RED 14
#define PIN_LED_YELLOW 13
#define PIN_LED_GREEN 12

// button
#define PIN_BUTTON 4
#define DEBOUNCE_TIME 200 // milliseconds
volatile int button_a_count;
volatile unsigned long count_prev_time;
volatile unsigned long first_press_time;

// Wifi
#include <ESP8266WiFi.h>
const char *WIFI_SSID = "EMLI_TEAM_13";
const char *WIFI_PASSWORD = "embeddedlinux";

const char *mqtt_broker = "192.168.10.1";
const int mqtt_port = 1883;
const char *mqtt_username = "team13";
const char *mqtt_password = "password";

bool pump_alarm = false;
bool plant_alarm = false;
bool needs_water = false;

#include <PubSubClient.h>
WiFiClient espClient;
PubSubClient mqttClient(espClient);

ICACHE_RAM_ATTR void button_a_isr()
{
  if (millis() - count_prev_time > DEBOUNCE_TIME)
  {
    count_prev_time = millis();
    button_a_count++;
  }

  if (button_a_count == 1)
  {
    first_press_time = count_prev_time;
  }
}

void callback(char *topic, byte *payload, unsigned int length)
{

  Serial.print("Message arrived in topic \"");
  Serial.print(topic);
  Serial.print("\": \"");
  String message;

  for (int i = 0; i < length; i++)
  {
    Serial.print((char)payload[i]);
    message += (char)payload[i];
  }
  Serial.println("\"");

  if (String(topic).endsWith("pump_alarm"))
  {
    pump_alarm = message == "1";
  }
  else if (String(topic).endsWith("plant_alarm"))
  {
    plant_alarm = message == "1";
  }
  else if (String(topic).endsWith("needs_water"))
  {
    needs_water = message == "1";
  }
}

void reconnect()
{
  while (!mqttClient.connected())
  {
    Serial.print("Connecting to MQTT broker...");
    // Attempt to connect
    if (mqttClient.connect("ESP8266", mqtt_username, mqtt_password))
    {
      Serial.println(" Connected!");
      mqttClient.subscribe("team13/watering/e66118c4e34d3521/sensors/#");
    }
    else
    {
      Serial.print("Failed to connect to MQTT broker, rc=");
      Serial.println(mqttClient.state());
      delay(5000);
    }
  }
}

void setup()
{
  // serial
  Serial.begin(115200);
  while (!Serial)
    ;

  // LEDs
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);
  pinMode(PIN_LED_RED, OUTPUT);
  digitalWrite(PIN_LED_RED, LOW);
  pinMode(PIN_LED_YELLOW, OUTPUT);
  digitalWrite(PIN_LED_YELLOW, LOW);
  pinMode(PIN_LED_GREEN, OUTPUT);
  digitalWrite(PIN_LED_GREEN, LOW);

  // button
  pinMode(PIN_BUTTON, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(PIN_BUTTON), button_a_isr, RISING);

  // set the ESP8266 to be a WiFi-client
  WiFi.mode(WIFI_STA);

  // connect to Wifi access point
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WIFI_SSID);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  digitalWrite(LED_BUILTIN, HIGH);
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("");

  mqttClient.setServer(mqtt_broker, mqtt_port);
  mqttClient.setCallback(callback);
}

void loop()
{
  reconnect();

  bool alarming = pump_alarm || plant_alarm;

  digitalWrite(PIN_LED_GREEN, !alarming);
  digitalWrite(PIN_LED_RED, alarming);
  digitalWrite(PIN_LED_YELLOW, needs_water);

  if (millis() - first_press_time >= 2000)
  {
    if (button_a_count == 1)
    {
      mqttClient.publish("team13/watering/e66118c4e34d3521/actuators/pump", "1");
    }

    button_a_count = 0;
    first_press_time = 0;
  }

  mqttClient.loop();
}
