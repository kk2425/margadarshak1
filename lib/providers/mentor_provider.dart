// providers/mentor_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mentor_models.dart';

// Mentor Profile Provider
final mentorProfileProvider = StateProvider<MentorProfile>((ref) {
  return MentorProfile(
    id: '1',
    name: 'Sarah Johnson',
    email: 'sarah@stanford.edu',
    college: 'Stanford University',
    year: 2024,
    expertise: 'UX Design • Product Management',
    domains: ['UX Design', 'Product Management', 'Business'],
    bio: 'Passionate about helping students navigate their academic journey. With experience in product design.',
    isVerifiedMentor: true,
    profileImageUrl: 'https://placehold.co/100x100/6366F1/FFFFFF?text=SJ',
    stats: MentorshipStats(
      studentsHelped: 47,
      avgResponseTime: 3.2,
      questionsAnswered: 89,
      sessions: 5,
    ),
  );
});

// Help Requests Provider
final helpRequestsProvider = StateProvider<List<HelpRequest>>((ref) {
  return [
    HelpRequest(
      id: '1',
      studentName: 'Alex Chen',
      studentImageUrl: 'https://placehold.co/100x100/10B981/FFFFFF?text=AC',
      question: 'How do I do user research for my final year project? I need to...',
      timestamp: '15 min',
      tags: ['UX Design', 'Research'],
    ),
    HelpRequest(
      id: '2',
      studentName: 'Anonymous',
      studentImageUrl: 'https://placehold.co/100x100/6B7280/FFFFFF?text=A',
      question: 'What are the best practices for framing user interviews with limited data?',
      timestamp: '24 min',
      tags: ['AI/ML', 'MIT'],
    ),
    HelpRequest(
      id: '3',
      studentName: 'Maria Rodriguez',
      studentImageUrl: 'https://placehold.co/100x100/EC4899/FFFFFF?text=MR',
      question: 'Career advice: Should I pursue a in frontend or go full-stack?',
      timestamp: '1d ago',
      tags: ['Development', 'IIITD-M'],
    ),
  ];
});

// Ongoing Conversations Provider
final ongoingConversationsProvider = StateProvider<List<OngoingConversation>>((ref) {
  return [
    OngoingConversation(
      id: '1',
      studentName: 'Portfolio Review Help',
      studentImageUrl: 'https://placehold.co/100x100/6366F1/FFFFFF?text=PR',
      lastMessage: 'Thanks! 2h ago',
      timestamp: '2h ago',
      isUnread: false,
      conversationType: 'Career Thread',
    ),
    OngoingConversation(
      id: '2',
      studentName: 'Machine Learning Career Path',
      studentImageUrl: 'https://placehold.co/100x100/10B981/FFFFFF?text=ML',
      lastMessage: 'Thanks! 2h ago',
      timestamp: '3d ago',
      isUnread: false,
      conversationType: 'View Thread',
    ),
    OngoingConversation(
      id: '3',
      studentName: 'React vs Vue Decision',
      studentImageUrl: 'https://placehold.co/100x100/F59E0B/FFFFFF?text=RV',
      lastMessage: 'Could you... 5d ago',
      timestamp: '5d ago',
      isUnread: false,
      conversationType: 'View Thread',
    ),
  ];
});

// Messages Provider
final messagesProvider = StateProvider<List<Message>>((ref) {
  return [
    Message(
      id: '1',
      senderId: 's1',
      senderName: 'Sarah Johnson',
      senderImageUrl: 'https://placehold.co/100x100/6366F1/FFFFFF?text=SJ',
      message: 'Hey, I completed the quiz but I\'m not...',
      timestamp: '2:47 PM',
      isRead: true,
    ),
    Message(
      id: '2',
      senderId: 's2',
      senderName: 'Mike Chen',
      senderImageUrl: 'https://placehold.co/100x100/10B981/FFFFFF?text=MC',
      message: 'I need you help to with Notebook and my proj...',
      timestamp: '2:47 PM',
      isRead: false,
    ),
    Message(
      id: '3',
      senderId: 's3',
      senderName: 'Emma Davis',
      senderImageUrl: 'https://placehold.co/100x100/EC4899/FFFFFF?text=ED',
      message: 'Can fill in as the mentors today...',
      timestamp: 'Yesterday',
      isRead: true,
    ),
    Message(
      id: '4',
      senderId: 's4',
      senderName: 'Alex Rodriguez',
      senderImageUrl: 'https://placehold.co/100x100/F59E0B/FFFFFF?text=AR',
      message: 'Perfect! Just let me know when you...',
      timestamp: 'Yesterday',
      isRead: true,
    ),
  ];
});

// Accepting Questions Toggle Provider
final acceptingQuestionsProvider = StateProvider<bool>((ref) => true);