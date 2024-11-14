import 'package:get/get.dart';
import 'package:universe_soft_it/repository/home_video_repository.dart';
import '../models/video_and_image_url.dart';
import '../models/video_url_model.dart';

class HomeContentViewModel extends GetxController {

  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = "".obs;
  List<VideoUrlImageModel> _videoUrlImageList = [];

  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;
  List<VideoUrlImageModel> get videoUrlImageList => _videoUrlImageList;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeContent();
  }



  Future<bool> homeContent() async {
    _videoUrlImageList.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await HomeVideoRepository.homeContentVideo();

    if (response.isSuccess) {
      final List<dynamic> videoData = response.responseData as List<dynamic>;
      _videoUrlImageList = videoData.map((json) {
        final videoUrlModel = VideoUrlModel.fromJson(json);
        return VideoUrlImageModel(
          videoUrl: videoUrlModel.videoUrl,
          imageUrl: videoUrlModel.imageUrl,
        );
      }).toList();
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage;
      _isSuccess.value = false;
    }

    _inProgress.value = false;
    update();
    return _isSuccess.value;
  }
}
