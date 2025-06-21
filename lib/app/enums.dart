// ignore_for_file: constant_identifier_names

enum AppLanguage {
  ar,
  en,
}

enum FilterType { dropdown_multiple, number, range, checkbox, rating, dropdown }

enum ProfileTabs { About, Reviews, Services, Portfolio }

enum ChatsTabs { All, Unread, Starred, Spam }

// enum RequestType { All, Pending, Confirmed, InProgress, Completed, Cancelled }

enum ChatType {
  Bot,
  Users,
}

enum TicketStatus { Open, Pending, Resolved, Closed }

enum VerifyScreenType {
  forget_password,
  register,
}

enum PasswordScreenType {
  reset_password,
  update_password,
}

///
/// The [ErrorCode] enum is responsible of stating all the possible issues that can be retrieved from the API
///
/// Values:
///
/// * [ErrorCode.SERVER_ERROR] indicates that the server returned an undefined error
/// * [ErrorCode.WRONG_INPUT] returned when the server returns error 422 UnProcessable Entity
/// * [ErrorCode.NO_INTERNET_CONNECTION] returned when the device is not connected to a network
/// * [ErrorCode.FORBIDDEN] returned when the server returns 403 Forbidden
/// * [ErrorCode.TIMEOUT] returned when the request has timed out
/// * [ErrorCode.UNAUTHENTICATED] returned when the request returns that the user is unauthenticated
///

enum ErrorCode {
  SERVER_ERROR,
  UNAUTHENTICATED,
  TIMEOUT,
  NO_INTERNET_CONNECTION,
  WRONG_INPUT,
  PARSE_ERROR,
  FORBIDDEN,
  NOT_VERIFIED,
  REGISTERED_EMAIL,
  IDENTIFIER_TAKEN,
  CACH_ERROR,
  BAD_REQUEST
}

enum UserRoles {
  freelancer,
  client,
  non,
}

enum NotificationType {
  request,
  requestLog,
  newFreelancer,
  rate,
  quotation,
  chat,
  call,
  verified,
  support,
  service,
  portfolio,
}

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
}

enum ChatStatus {
  all,
  unread,
  starred,
  spam,
}
