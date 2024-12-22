

class ApiResource<T> {
  final ApiStatus status;
  final T? data;
  final String? message;
  Function()? action;
  bool? dialogSuccess = false;

  bool get hasData => data != null;
  bool get hasError => data == null && status == ApiStatus.ERROR;

  ApiResource.success(this.data)
      : status = ApiStatus.SUCCESS,
        message = null;

  ApiResource.loading()
      : status = ApiStatus.LOADING,
        data = null,
        message = null;

  ApiResource.error(this.message)
      : status = ApiStatus.ERROR,
        data = null;

  ApiResource.errorWithData(this.message, this.data)
      : status = ApiStatus.ERROR_WITH_DATA;

  ApiResource.idle()
      : status = ApiStatus.IDLE,
        data = null,
        message = null;

  ApiResource.showDialog(this.data, this.message, {this.dialogSuccess, this.action})
      : status = ApiStatus.SHOWDIALOG;

  ApiResource.timeout(this.message)
      : status = ApiStatus.TIMEOUT,
        data = null;
}

enum ApiStatus { LOADING, SUCCESS, ERROR, ERROR_WITH_DATA, IDLE, SHOWDIALOG, TIMEOUT }

class ApiResourceManager<T> {
  ApiResource<T> get idle => ApiResource.idle();
  ApiResource<T> success(T data) => ApiResource.success(data);
  ApiResource<T> loading() => ApiResource.loading();
  ApiResource<T> error(String message) => ApiResource.error(message);
  ApiResource<T> errorWithData(String message, T data) => ApiResource.errorWithData(message, data);
  ApiResource<T> showDialog(T data, String message, {bool? dialogSuccess, Function()? action}) => ApiResource.showDialog(data, message, dialogSuccess: dialogSuccess, action: action);
  ApiResource<T> timeout(String message) => ApiResource.timeout(message);
}