// import 'package:bloc/bloc.dart';
// // ignore: depend_on_referenced_packages
// import 'package:meta/meta.dart';
// import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';
// import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';

// part 'authentication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final auth = FirebaseAuthService();

//   AuthenticationBloc() : super(AuthenticationInitial()) {
//     on<AuthenticationEvent>((event, emit) {});

//     on<RegisterUser>((event, emit) async {
//       emit(const AuthenticationLoading(isLoading: true));
//       try {
//         final AppUser? user = await auth.registerUser(event.name, event.surname,
//             event.email, event.password,);
//         if (user != null) {
//           emit(AuthenticationSuccess(user));
//         } else {
//           emit(const AuthenticationFailure('Create user failed'));
//         }
//       } catch (e) {
//         print(e.toString());
//       }
//       emit(const AuthenticationLoading(isLoading: false));
//     });
//     on<LoginUser>((event, emit) async {
//       emit(const AuthenticationLoading(isLoading: true));
//       try {
//         final AppUser? user = await auth.loginUser(event.email, event.password);
//         if (user == null) {
//           throw Exception("Wrong email or password");
//         } else {
//           emit(AuthenticationSuccess(user));
//         }
//       } catch (e) {
//         print(e);
//       }
//     });
//     on<LogOut>((event, emit) async {
//       emit(const AuthenticationLoading(isLoading: true));
//       try {
//         auth.signOut();
//       } catch (e) {
//         print('Error');
//         print(e);
//       }
//       emit(const AuthenticationLoading(isLoading: false));
//     });
//   }
// }
