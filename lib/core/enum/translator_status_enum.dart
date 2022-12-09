enum TranslatorStatus {
  all('All'),
  online('Şu an Çeviriye Hazır'),
  busy('Şu an Çeviriye Hazır Değil');

  final String value;
  const TranslatorStatus(this.value);
}
