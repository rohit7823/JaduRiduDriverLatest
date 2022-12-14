enum AuditStep {
  chasisNumberImage("CHASIS_NUMBER_IMAGE"),
  backSideWithNumberPlate("BACK_SIDE_WITH_NUMBER_PLATE"),
  leftSideExterior("LEFT_SIDE_EXTERIOR"),
  rightSideExterior("RIGHT_SIDE_EXTERIOR"),
  carInside("CAR_INSIDE");

  final String key;
  const AuditStep(this.key);
}
