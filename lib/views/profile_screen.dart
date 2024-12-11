import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/profile_view_model.dart';
import 'package:first_application/views/statistical_widget.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.white,
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            final profile = viewModel.profile;
            if (profile == null) {
              return Center(
                child: Text('Проблемы с загрузкой профиля'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 200.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 50.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 370,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor, // Использование цвета темы
                        borderRadius:
                            BorderRadius.circular(16), // Закругленные края
                      ),
                      child: Center(
                        child: Text(
                          profile.username,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 370,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor, // Использование цвета темы
                        borderRadius:
                            BorderRadius.circular(16), // Закругленные края
                      ),
                      child: Center(
                        child: Text(
                          profile.email,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.0),
                  StatisticalWidget(
                    title: 'Рейтинг',
                    rating: profile.rating.toString(),
                  ),
                  SizedBox(height: 20.0),
                  StatisticalWidget(
                    title: 'Успешных задач',
                    rating: profile.successfulTasks.toString(),
                  ),
                  SizedBox(height: 20.0),
                  StatisticalWidget(
                    title: 'Среднее кол-во задач за день',
                    rating: profile.averageTasksPerDay.toString(),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
