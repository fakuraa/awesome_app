import 'package:awesome_app/base/base_controller.dart';
import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/model/src.dart';

class HomeController extends BaseController<Picture> {
  int viewMenu = 0;

  @override
  void onInit() {
    super.onInit();
    refreshPage();
  }

  @override
  get statusData => dataList;

  @override
  void refreshPage() {
    page.value = 1;
    loadData();
    update();
  }

  loadData() async {
    loadingState();
    await Future.delayed(Duration(seconds: 2));
    dataList.value = List.generate(
      10,
      (i) => Picture(
        id: 215367,
        width: 7360,
        height: 4912,
        url:
            "https://www.pexels.com/photo/person-using-smartphone-shallow-focus-photography-215367/",
        photographer: "thomas vanhaecht",
        photographerUrl: "https://www.pexels.com/@tphotography",
        photographerId: 19906,
        avgColor: "#7A7479",
        src: Src(
          original:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg",
          large2x:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          large:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
          medium:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&h=350",
          small:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&h=130",
          portrait:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
          landscape:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
          tiny:
              "https://images.pexels.com/photos/215367/pexels-photo-215367.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280",
        ),
        liked: false,
        alt:
            "Close-up of hands using a smartphone with a touchscreen, emphasizing mobile technology.",
      ),
    );
    successState();
  }

  void changeViewMenu(int item) {
    viewMenu = item;
    update();
  }
}
