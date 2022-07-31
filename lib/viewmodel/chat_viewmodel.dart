import 'package:dongheang/model/chat.dart';
import 'package:flutter/cupertino.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Chat> chats = [];

  ChatViewModel() {
    chats.addAll([
      Chat(
          title: '크로아티아 구서준 대기중',
          members: 2,
          maxMember: 2,
          tags: ['크로아티아', '동행', '구서준', '반석쿠']),
      Chat(
          title: '프랑스 동행 구해요 4명만!',
          members: 3,
          maxMember: 4,
          tags: ['프랑스', '20대만', '봉쥬르']),
      Chat(
          title: '제주도에서 노쉴?',
          members: 5,
          maxMember: 10,
          tags: ['한국', '제주도', '혼자옵서예', '게하']),
      Chat(
          title: '오사카에서 스시 먹자',
          members: 1,
          maxMember: 4,
          tags: ['일본', '오사카', '교토', '맛집', '스시']),
      Chat(
          title: '여행 갈곳 추천좀',
          members: 2,
          maxMember: 5,
          tags: ['유럽', '아메리카', '아프리카', '아마존']),
      Chat(
          title: '라스베이거스에서 한탕각',
          members: 32,
          maxMember: 50,
          tags: ['미국', '라스베베이거스', '카지노', '부자될래']),
    ]);
    notifyListeners();
  }
}
