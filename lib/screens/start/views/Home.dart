import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/models/shop_model.dart';
import 'package:lookea/providers/MainProvider.dart';
import 'package:lookea/screens/start/widgets/HomePersistentDelegate.dart';
import 'package:lookea/screens/start/widgets/HomeTabs.dart';
import 'package:lookea/screens/start/widgets/ShopCard.dart';
import 'package:lookea/screens/start/widgets/SliverPersistent.dart';
import 'package:lookea/widgets/LColors.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/cached_image.dart';
import 'package:lookea/widgets/text_input.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  ScrollController viewController = ScrollController();
  TabController tabController;
  List<String> shopTypes = ["Barberia", "Peluqueria", "Estilista"];

  @override
  void initState() {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    var model = LocalData.user;

    provider.currentTab = shopTypes.indexOf(model.shopType);
    tabController = TabController(initialIndex: shopTypes.indexOf(model.shopType), length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(),
        centerTitle: true,
        title: GestureDetector(
          onTap: ()  async {
            print("TO UP");
            SchedulerBinding.instance.addPostFrameCallback((_) {
            viewController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            });
          },
          child: Text("LOOKEÁ", style: TextStyle(color: LColors.black9, fontWeight: FontWeight.bold),),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: RefreshIndicator(
          onRefresh: () async{
            await provider.updateShops();
          },
          child: CustomScrollView(
            controller: viewController,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: HomePersistentHeaderDelegate(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate:  PersistentHeaderDelegate(
                  minExtends: 60,
                  maxExtents: 60,
                  child: Container(
                    color: Colors.white,
                    height: 60,
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      onTap: (int index){
                        provider.currentTab = index;
                        provider.notify();
                      },
                      tabs: [
                        HomeTab(icon: Icon( LIcons.razor, color: LColors.black9,), text: "Barberias", selected: provider.currentTab == 0),
                        HomeTab(icon:Icon( LIcons.scissors, color: LColors.black9,), text: "Peluquerias", selected: provider.currentTab == 1),
                        HomeTab(icon: Icon( LIcons.hair_dryer, color: LColors.black9,), text: "Estilistas", selected: provider.currentTab == 2),
                        HomeTab(icon: Icon( LIcons.apps, size: 14, color: LColors.black9,), text: "Todos", selected: provider.currentTab == 3)
                      ],
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: provider.searchShops(),
                builder: (_, shops){
                  if(shops.hasData){
                    List<ShopModel> proximityModels = provider.currentTab == 3 ? provider.shops.values.expand((element) => element).toList() : provider.shops["${provider.currentTab}"];
                    if(proximityModels.isNotEmpty){
                      return SliverList(
                        delegate: SliverChildListDelegate(proximityModels.map((e) => ShopCard(model: e, onTap: () => Navigator.pushNamed(context, "/shop", arguments: e),)).toList())
                      );
                    }else{
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LIcons.sad, color: LColors.white26,),
                                Text("No encontramos locales cerca", style: TextStyle(color: LColors.white26),)
                              ],
                            )
                          ),
                        ),
                      );
                    }
                  }else{
                    return SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    );
                  }
                },
              )
            ],
          ),
        )
      )
    );
  }
}