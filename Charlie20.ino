extern "C" volatile void TIMER0_OVF_vector(void);

void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:
  TIMER0_OVF_vector();
}
