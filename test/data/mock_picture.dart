import 'package:awesome_app/base/base_response.dart';
import 'package:awesome_app/base/environment.dart';
import 'package:awesome_app/model/picture.dart';

BaseResponse pictureEmptyResponse = BaseResponse(
  status: 200,
  message: 'Request was successful',
  domain: Environment.domain,
  page: 1,
  perPage: 20,
  data: [],
);

BaseResponse picturesResponse = BaseResponse(
  status: 200,
  message: 'Request was successful',
  domain: Environment.domain,
  data: [
    Picture(id: 1, src: null),
    Picture(id: 2, src: null),
  ],
  perPage: 20,
  nextPage: "there is more",
);
