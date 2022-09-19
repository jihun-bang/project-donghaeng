// 서비스하는 나라
enum Country {
  france('프랑스'), // 프랑스
  czech('체코'), // 체코
  croatia('크로아티아'); // 크로아티아

  final String korean;
  const Country(this.korean);
}

// todo: 지훈쓰 : enum을 어디다가 만들지 헷갈리는데, 일단은 어디든 종속되면 안되고 독립적은 값이니까 domain/resource 만들어서 뒀는데 어떻게 생각해요?
// domain/models에 만들지 고민하다가, 뭔가 models느낌은 아니여서 resource를 만들었어요.
// 혹은 새로은 layer를 만드는것도 괜찮을꺼같은데, 관리해야하는게 늘어나니까 이건 아닌거같구
