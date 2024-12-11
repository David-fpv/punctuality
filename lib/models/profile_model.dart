class Profile {
  final int userId;
  final String username;
  final String email;
  final int rating;
  final int successfulTasks;
  final int averageTasksPerDay;

  Profile({
    required this.userId,
    required this.username,
    required this.email,
    required this.rating,
    required this.successfulTasks,
    required this.averageTasksPerDay,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'rating': rating,
      'succesful_tasks': successfulTasks,
      'average_tasks_per_day': averageTasksPerDay,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userId: map['user_id'],
      username: map['username'] ?? 'No username',
      email: map['email'] ?? 'No email',
      rating: map['rating'] ?? 0,
      successfulTasks: map['succesful_tasks'] ?? 0,
      averageTasksPerDay: map['average_tasks_per_day'] ?? 0,
    );
  }
}