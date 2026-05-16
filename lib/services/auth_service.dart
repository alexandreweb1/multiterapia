import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String? get currentUserId => _auth.currentUser?.uid;

  /// Cadastra novo usuário e salva perfil no Firestore.
  /// Para pacientes, [therapistId] vincula ao terapeuta pelo UID.
  /// Para terapeutas, [specialty] e [professionalRegistry] descrevem a atuação.
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? therapistId,
    Specialty specialty = Specialty.none,
    String? professionalRegistry,
    int? age,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    // Se qualquer passo abaixo falhar, removemos o usuário recém-criado do
    // Firebase Auth para evitar contas órfãs (Auth sem doc no Firestore) que
    // depois travam o login com "email já cadastrado".
    try {
      String? validatedTherapistId;
      if (role == UserRole.patient &&
          therapistId != null &&
          therapistId.isNotEmpty) {
        try {
          final therapistDoc =
              await _db.collection('users').doc(therapistId).get();
          if (!therapistDoc.exists ||
              therapistDoc.data()?['role'] != 'therapist') {
            throw Exception('ID do terapeuta inválido ou não encontrado.');
          }
          validatedTherapistId = therapistId;
        } on FirebaseException catch (e) {
          if (e.code == 'permission-denied') {
            throw Exception(
                'Não foi possível validar o ID do terapeuta (permissão negada nas regras do Firestore).');
          }
          rethrow;
        }
      }

      final userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        role: role,
        therapistId: validatedTherapistId,
        createdAt: DateTime.now(),
        specialty: specialty,
        professionalRegistry:
            role == UserRole.therapist ? professionalRegistry : null,
        age: role == UserRole.patient ? age : null,
      );

      await _db.collection('users').doc(uid).set(userModel.toFirestore());
      return userModel;
    } catch (_) {
      try {
        await credential.user!.delete();
      } catch (_) {
        // best-effort: se não der pra deletar, deixamos a exceção original subir
      }
      rethrow;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async => _auth.signOut();
}
