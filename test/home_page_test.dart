import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:awesome_app/pages/home/home_page.dart';
import 'package:awesome_app/pages/home/widgets/responsive_grid.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockHomeController extends Mock implements HomeController {}

void main() {
  testWidgets('HomePage UI Test - Refresh and Load More',
      (WidgetTester tester) async {
    final mockController = MockHomeController();

    when(mockController.refreshPage()).thenAnswer((_) async {});
    when(mockController.loadMore()).thenAnswer((_) async {});

    await tester.pumpWidget(
      GetMaterialApp(
        home: HomePage(),
        initialBinding: BindingsBuilder(() {
          Get.put<HomeController>(mockController);
        }),
      ),
    );

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);

    await tester.drag(find.byType(EasyRefresh), const Offset(0, 200));
    await tester.pumpAndSettle();

    verify(mockController.refreshPage()).called(1);

    expect(find.byType(ResponsiveGrid), findsOneWidget);
    expect(find.byType(ListView), findsNothing);

    await tester.drag(find.byType(EasyRefresh), const Offset(0, -200));
    await tester.pumpAndSettle();

    verify(mockController.loadMore()).called(1);

    when(mockController.isError).thenReturn(true);
    await tester.pumpAndSettle();

    expect(find.text('Ops Something went wrong...'), findsOneWidget);
  });
}
