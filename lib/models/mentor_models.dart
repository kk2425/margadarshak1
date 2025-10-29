// models/mentor_models.dart

class MentorProfile {
  final String id;
  final String name;
  final String email;
  final String college;
  final int year;
  final String expertise;
  final List<String> domains;
  final String bio;
  final bool isVerifiedMentor;
  final String profileImageUrl;
  final MentorshipStats stats;

  MentorProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.college,
    required this.year,
    required this.expertise,
    required this.domains,
    required this.bio,
    this.isVerifiedMentor = false,
    required this.profileImageUrl,
    required this.stats,
  });
}

class MentorshipStats {
  final int studentsHelped;
  final double avgResponseTime; // in hours
  final int questionsAnswered;
  final int sessions;

  MentorshipStats({
    required this.studentsHelped,
    required this.avgResponseTime,
    required this.questionsAnswered,
    required this.sessions,
  });
}

class HelpRequest {
  final String id;
  final String studentName;
  final String studentImageUrl;
  final String question;
  final String timestamp;
  final List<String> tags;
  final String priority; // 'high', 'medium', 'low'

  HelpRequest({
    required this.id,
    required this.studentName,
    required this.studentImageUrl,
    required this.question,
    required this.timestamp,
    required this.tags,
    this.priority = 'medium',
  });
}

class OngoingConversation {
  final String id;
  final String studentName;
  final String studentImageUrl;
  final String lastMessage;
  final String timestamp;
  final bool isUnread;
  final String conversationType; // 'Career Thread', 'View Thread', etc.

  OngoingConversation({
    required this.id,
    required this.studentName,
    required this.studentImageUrl,
    required this.lastMessage,
    required this.timestamp,
    this.isUnread = false,
    required this.conversationType,
  });
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImageUrl;
  final String message;
  final String timestamp;
  final bool isRead;
  final bool isReplied;
  final MessageType type;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImageUrl,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.isReplied = false,
    this.type = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  file,
  link,
}

class AcceptingQuestionsConfig {
  final bool isAccepting;
  final String toggleOffMessage;
  final int currentlyAcceptingCount;

  AcceptingQuestionsConfig({
    required this.isAccepting,
    required this.toggleOffMessage,
    required this.currentlyAcceptingCount,
  });
}
