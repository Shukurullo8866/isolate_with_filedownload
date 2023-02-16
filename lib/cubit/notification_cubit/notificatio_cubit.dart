import 'package:bloc/bloc.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../service/locol_notification/notification.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final password = RandomPasswordGenerator();



  sendNotification({ bool isFinished=false}){
    String newPassword = password.randomPassword(numbers: true,passwordLength: 4,letters: false);
    LocalNotificationService.localNotificationService.showNotification(id: int.parse(newPassword), title: isFinished?"File downloading has finished":"File downlaoding");
  }
}
