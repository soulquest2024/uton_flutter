

class ApiResource<T> {
  late final ApiStatus status;
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

