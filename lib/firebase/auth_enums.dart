enum EmailSignUpResults {
  registerCompleted,
  emailAlreadyPresent,
  registerNotCompleted,
}

enum EmailLogInResults {
  signInCompleted,
  emailNotVerified,
  emailOrPasswordInvalid,
  unexpectedError,
}

enum GoogleSignInResults {
  signInCompleted,
  signInNotCompleted,
  alreadySignedIn,
  unexpectedError,
}

enum PhoneSignInResults {
  signInCompleted,
  signInNotCompleted,
  alreadySignedIn,
  unExpectedError,
}
