import 'package:flutter_test/flutter_test.dart';
import '../../../../../lib/domain/study/entities/study_topic_detail.dart';

void main() {
  group('StudyTopicDetail Entity Tests', () {
    test('should create StudyTopicDetail with all required fields', () {
      const topicDetail = StudyTopicDetail(
        id: '1',
        title: 'Pronouns',
        amharicTitle: 'መርዛዊት',
        description: 'Learn about Amharic pronouns',
        amharicDescription: 'የአማርኛ መርዛዊት ንግግር',
        examples: ['አንዱ - I', 'አንቺ - You (female)'],
        rules: ['Rule 1', 'Rule 2'],
        itemCount: 25,
        isAvailable: true,
      );

      expect(topicDetail.id, equals('1'));
      expect(topicDetail.title, equals('Pronouns'));
      expect(topicDetail.amharicTitle, equals('መርዛዊት'));
      expect(topicDetail.description, equals('Learn about Amharic pronouns'));
      expect(topicDetail.amharicDescription, equals('የአማርኛ መርዛዊት ንግግር'));
      expect(topicDetail.examples, hasLength(2));
      expect(topicDetail.rules, hasLength(2));
      expect(topicDetail.itemCount, equals(25));
      expect(topicDetail.isAvailable, isTrue);
    });

    test('should create StudyTopicDetail with empty lists', () {
      const topicDetail = StudyTopicDetail(
        id: '2',
        title: 'Empty Topic',
        amharicTitle: 'ባዶ ርዕስ',
        description: 'Empty description',
        amharicDescription: 'ባዶ መግለጫ',
        examples: [],
        rules: [],
        itemCount: 0,
        isAvailable: false,
      );

      expect(topicDetail.examples, isEmpty);
      expect(topicDetail.rules, isEmpty);
      expect(topicDetail.itemCount, equals(0));
      expect(topicDetail.isAvailable, isFalse);
    });

    test('should handle equality correctly', () {
      const topicDetail1 = StudyTopicDetail(
        id: '1',
        title: 'Test',
        amharicTitle: 'ሙከራ',
        description: 'Test description',
        amharicDescription: 'ሙከራ መግለጫ',
        examples: ['Ex1'],
        rules: ['Rule1'],
        itemCount: 5,
        isAvailable: true,
      );

      const topicDetail2 = StudyTopicDetail(
        id: '1',
        title: 'Test',
        amharicTitle: 'ሙከራ',
        description: 'Test description',
        amharicDescription: 'ሙከራ መግለጫ',
        examples: ['Ex1'],
        rules: ['Rule1'],
        itemCount: 5,
        isAvailable: true,
      );

      expect(topicDetail1, equals(topicDetail2));
    });

    test('should handle different instances correctly', () {
      const topicDetail1 = StudyTopicDetail(
        id: '1',
        title: 'Topic 1',
        amharicTitle: 'ርዕስ 1',
        description: 'Description 1',
        amharicDescription: 'መግለጫ 1',
        examples: [],
        rules: [],
        itemCount: 5,
        isAvailable: true,
      );

      const topicDetail2 = StudyTopicDetail(
        id: '2',
        title: 'Topic 2',
        amharicTitle: 'ርዕስ 2',
        description: 'Description 2',
        amharicDescription: 'መግለጫ 2',
        examples: [],
        rules: [],
        itemCount: 10,
        isAvailable: false,
      );

      expect(topicDetail1, isNot(equals(topicDetail2)));
      expect(topicDetail1.id, isNot(equals(topicDetail2.id)));
      expect(topicDetail1.itemCount, isNot(equals(topicDetail2.itemCount)));
    });

    test('should handle Amharic text properly', () {
      const topicDetail = StudyTopicDetail(
        id: '1',
        title: 'Pronouns',
        amharicTitle: 'መርዛዊት',
        description: 'Amharic pronouns explanation',
        amharicDescription: 'መርዛዊት ወርርወ /ወራ/ ከሚለው-ገባ ተገኝ ሲሆን',
        examples: ['አንዱ - እኔ', 'ንሕኔ- እኛ'],
        rules: ['መርዛዊት ሲተካ ቃላቶችን ይተካል'],
        itemCount: 10,
        isAvailable: true,
      );

      expect(topicDetail.amharicTitle.contains('መ'), isTrue);
      expect(topicDetail.amharicDescription.contains('መርዛዊት'), isTrue);
      expect(topicDetail.examples.first.contains('አንዱ'), isTrue);
      expect(topicDetail.rules.first.contains('መርዛዊት'), isTrue);
    });

    test('should handle props correctly', () {
      const topicDetail = StudyTopicDetail(
        id: '1',
        title: 'Test',
        amharicTitle: 'ሙከራ',
        description: 'Test',
        amharicDescription: 'ሙከራ',
        examples: ['Ex1'],
        rules: ['Rule1'],
        itemCount: 5,
        isAvailable: true,
      );

      expect(topicDetail.props, contains('1'));
      expect(topicDetail.props, contains('Test'));
      expect(topicDetail.props, contains('ሙከራ'));
      expect(topicDetail.props, contains(5));
      expect(topicDetail.props, contains(true));
    });
  });
} 