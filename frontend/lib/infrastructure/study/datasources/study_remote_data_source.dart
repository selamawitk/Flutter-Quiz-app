import '../../../domain/study/entities/study_topic.dart';
import '../../../domain/study/entities/study_topic_detail.dart';

abstract class StudyRemoteDataSource {
  Future<List<StudyTopic>> getStudyTopics();
  Future<StudyTopicDetail> getStudyTopicDetail(String id);
}

class StudyRemoteDataSourceImpl implements StudyRemoteDataSource {
  @override
  Future<List<StudyTopic>> getStudyTopics() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Return the topics shown in the screenshot
    return const [
      StudyTopic(
        id: '1',
        title: 'Pronouns',
        amharicTitle: 'መርዛዊት',
        description: 'Learn about Amharic pronouns',
        isAvailable: true,
        itemCount: 25,
      ),
      StudyTopic(
        id: '2',
        title: 'Verbs',
        amharicTitle: 'ግስ',
        description: 'Learn about Amharic verbs',
        isAvailable: true,
        itemCount: 40,
      ),
      StudyTopic(
        id: '3',
        title: 'Nouns',
        amharicTitle: 'ስም',
        description: 'Learn about Amharic nouns',
        isAvailable: true,
        itemCount: 35,
      ),
      StudyTopic(
        id: '4',
        title: 'Adjectives',
        amharicTitle: 'ቅጽል',
        description: 'Learn about Amharic adjectives',
        isAvailable: true,
        itemCount: 20,
      ),
      StudyTopic(
        id: '5',
        title: 'Numbers',
        amharicTitle: 'አሃዝ',
        description: 'Learn about Amharic numbers',
        isAvailable: true,
        itemCount: 15,
      ),
      // Example of an unavailable topic (won't show in UI)
      StudyTopic(
        id: '6',
        title: 'Advanced Grammar',
        amharicTitle: 'የላቀ ሰዋሰው',
        description: 'Advanced Amharic grammar rules',
        isAvailable: false,
        itemCount: 0,
      ),
    ];
  }

  @override
  Future<StudyTopicDetail> getStudyTopicDetail(String id) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Return detailed information based on the ID (matching screenshot content)
    switch (id) {
      case '1': // Pronouns
        return const StudyTopicDetail(
          id: '1',
          title: 'Pronouns',
          amharicTitle: 'መርዛዊት',
          description: 'Learn about Amharic pronouns and their usage in sentences',
          amharicDescription: 'መርዛዊት ወርርወ /ወራ/ ከሚለው-ገባ ተገኝ ሲሆን\n\nወቀኞች ፈታወራሬኞች ወሚለወ ኔርኦች ይይላል፡:\n\nመርዛዊት ወሚሳኔ በግንኣ ሲሻና አሰር ኽኦወ አርራሞ:\n\nአነ - እኔ\n\nንሕኔ- እኛ\n\nአንት - አንተ\n\nአንትም - አንትም\n\nአንት - አንች\n\nአንተነ - አንተነ\n\nወአቶ - እሱ\n\nወአትም/እወኖነ/ - አርረኦ\n\nይእነ - እነሱ\n\nወአኖ/እወኖነ/ - አርረኦ',
          examples: [
            'አነ - እኔ',
            'ንሕኔ- እኛ', 
            'አንት - አንተ',
            'አንትም - አንትም',
            'አንት - አንች',
            'አንተነ - አንተነ',
            'ወአቶ - እሱ',
            'ወአትም/እወኖነ/ - አርረኦ',
            'ይእነ - እነሱ',
            'ወአኖ/እወኖነ/ - አርረኦ'
          ],
          rules: [
            'መርዛዊት ወርርወ /ወራ/ ከሚለው-ገባ ተገኝ ሲሆን',
            'ወቀኞች ፈታወራሬኞች ወሚለወ ኔርኦች ይይላል፡:',
            'መርዛዊት ወሚሳኔ በግንኣ ሲሻና አሰር ኽኦወ አርራሞ:'
          ],
          itemCount: 25,
          isAvailable: true,
        );
      
      case '2': // Verbs
        return const StudyTopicDetail(
          id: '2',
          title: 'Verbs',
          amharicTitle: 'ግስ',
          description: 'Learn about Amharic verbs and their conjugations',
          amharicDescription: 'ግስ በአማርኛ ተቀስቅሶ ናቸው የሚለውን ጥናት ማድረግ ያስፈልጋል። ግስ ብዙ ዓይነት አለው፣ ይህም የሰዋስው ዋና አካል ሲሆን ዓረፍተ ነገር ለመሥራት ያስፈልጋል።',
          examples: [
            'ሄደ - went',
            'መጣ - came',
            'በላ - ate',
            'ተኛ - slept',
            'ሰራ - worked'
          ],
          rules: [
            'ግስ የተግባር ወይም የሁኔታ መግለጫ ነው',
            'በዘመን እና በሰው ይለወጣል',
            'ዓረፍተ ነገር ለመሥራት ያስፈልጋል'
          ],
          itemCount: 40,
          isAvailable: true,
        );

      case '3': // Nouns  
        return const StudyTopicDetail(
          id: '3',
          title: 'Nouns',
          amharicTitle: 'ስም',
          description: 'Learn about Amharic nouns and their classifications',
          amharicDescription: 'ስም በአማርኛ ሰዋስው ውስጥ ቁምነገር ያለው አካል ሲሆን፣ የሰው፣ የቦታ፣ የነገር እና የሀሳብ ስም መግለጫ ነው።',
          examples: [
            'ሰው - person',
            'ቤት - house', 
            'መጽሐፍ - book',
            'ውሃ - water',
            'ፍቅር - love'
          ],
          rules: [
            'ስም የሰው፣ የቦታ፣ የነገር ስም ነው',
            'በቁጥር ይለወጣል (ብዙ/ነጠላ)',
            'በፆታ ይለያያል (ወንድ/ሴት)'
          ],
          itemCount: 35,
          isAvailable: true,
        );

      case '4': // Adjectives
        return const StudyTopicDetail(
          id: '4', 
          title: 'Adjectives',
          amharicTitle: 'ቅጽል',
          description: 'Learn about Amharic adjectives and their usage',
          amharicDescription: 'ቅጽል የነገርን ባህሪ፣ ሁኔታ ወይም ጥራት የሚገልጽ ሰዋስው አካል ነው። ከስም ጋር በመተሳሰር ጥቅም ላይ ይውላል።',
          examples: [
            'ቆንጆ - beautiful',
            'ትልቅ - big',
            'ትንሽ - small', 
            'ቀይ - red',
            'ጥሩ - good'
          ],
          rules: [
            'ቅጽል ከስም ቀጥሎ ይቀመጣል',
            'ከስሙ ጋር በፆታ እና በቁጥር ይስማማል',
            'የነገርን ባህሪ ይገልጻል'
          ],
          itemCount: 20,
          isAvailable: true,
        );

      case '5': // Numbers
        return const StudyTopicDetail(
          id: '5',
          title: 'Numbers',
          amharicTitle: 'አሃዝ',
          description: 'Learn about Amharic numbers and counting',
          amharicDescription: 'አሃዝ በአማርኛ መቁጠር እና የቁጥር ስርዓትን ለመረዳት አስፈላጊ ሰዋስው አካል ነው።',
          examples: [
            'አንድ - one (1)',
            'ሁለት - two (2)',
            'ሦስት - three (3)',
            'አራት - four (4)',
            'አምስት - five (5)'
          ],
          rules: [
            'የአማርኛ ቁጥሮች ልዩ ስርዓት አላቸው',
            'ከስም ጋር በመተሳሰር ይጠቀማሉ',
            'በሠዋ አሠራር ይለወጣሉ'
          ],
          itemCount: 15,
          isAvailable: true,
        );

      default:
        throw Exception('Topic not found');
    }
  }
} 