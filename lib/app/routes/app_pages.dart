import 'package:bdcalling_task/app/modules/login/widgets/verify_user.dart';
import 'package:get/get.dart';

import '../APIs/auth_middleware/auth_middleware.dart';
import '../modules/dashboard/binding/dashboard_binding.dart';
import '../modules/dashboard/view/dashboard_view.dart';

import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_view.dart';

import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

import '../modules/profile/binding/profile_binding.dart';
import '../modules/profile/view/profile_view.dart';
import '../modules/profile/widgets/profile_edit_widget.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/tasks/binding/task_binding.dart';
import '../modules/tasks/view/task_create_view.dart';
import '../modules/tasks/view/task_view.dart';



class AppPages {
  static const initial = Routes.tasks;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardView(),
      binding: DashboardBinding(),
        middlewares: [AuthMiddleware()], // Attach middleware here
    ),
    //     GetPage(
    //   name: '/contest/:id',
    //   page: () => SingleContestView(),
    //   binding: SingleContestBinding(),
    // ),
GetPage(
  name: Routes.profile,
  page: () => ProfileView(),
  binding: ProfileBinding(),
),
GetPage(
  name: Routes.editProfile,
  page: () => ProfileEditView(),
  binding: ProfileBinding(),
),
      GetPage(
          name:Routes.tasks,
          page: () => TaskListView(),
          binding: TaskBinding(),
            middlewares: [AuthMiddleware()], // Attach middleware here
        ),
        GetPage(
          name: Routes.createTask,
          page: () => TaskCreateView(),
          binding: TaskBinding(),
            middlewares: [AuthMiddleware()], // Attach middleware here
        ),
        GetPage(
          name: Routes.verification,
          page: () => VerificationView(),
          binding: DashboardBinding(),
            middlewares: [AuthMiddleware()], // Attach middleware here
        ),
  ];
}

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const createTask = '/create-task';
  static const tasks = '/tasks';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const verification = '/verification';

    // Dynamic route generator for single contest
  // static String singleBiodata(String id) => '/single-biodata/$id';

}
