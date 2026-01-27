import 'package:flutter/material.dart';
import 'package:web_of_edss/MyAppBar.dart';
import 'package:web_of_edss/MyBottomNavigationBar.dart';
import 'package:web_of_edss/Widget.dart';

class GuangAnDistrictPage extends StatelessWidget{
  const GuangAnDistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
            
          ),
        ),
        child: Stack(
          children: [
            ListView(
              physics: ClampingScrollPhysics(),
              cacheExtent: 500.0,

              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(padding: EdgeInsets.all(100),
                      child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText("广安区"),
                              
                              SubTitleText("第一章 绪论"),
                               Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''广安区是北方工业区目前建筑面积最大，劳动力数量最多，发展最迅速，活跃人口最多的区域，是服务器目前最大的核心，承担着服务器的工业中心，经济中心，科技创新中心等。

广安区自4月11日以来又借助服务器机械动力模组优势，凭借资源优势，交通优势，积极发展高新技术产业（指装配精密构件的产业），机械动力重工业等，力争上游，走多产业链工业化路线

总之，广安区将继续发扬优势，争取建立规模化和产业化的工业体系
'''),
                              SubTitleText("第二章 工业区规划"),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''广安区有着多样化的工业区，借助工业区数量优势，我们可以发展以各种技术产业为代表的复杂工业

我们在原版工业方面有着自动树场，刷铁机，村民繁殖机，自动熔炉等工业设施，八核刷铁机也正在建造（其实已经鸽了，目前成为服务器最大的工业遗址），同时，我们正筹备发展村民交易等产业，并建立了GDTC，后来几乎废弃，里面的村民还被雷劈了，变成女巫，至今仍未处理。

在机械动力方面，我们也在持续发展着机械动力产业，目前已经建立了广安第一机械制造厂以及广安坚固板制造产业链，在之后的建设中，广安区独立自主研发并建造了一个高速鼓风炉（如视频所示，效率理论可达153.6万），之后又研发了高效区块型盾构机，解决了北方工业区的资源，特别是黄铜资源的紧缺问题，又通过蓝图神力。建造了主世界最大的人工汲取岩浆池，并开启了广安区一期居民楼建设

我们也从未探索区域部分区块收集到了许多的资源，比如黄铜，目前北方工业区的存量大约为60组，另外我们还含有约120组铜，不包含铁块住宅铁的储量大约为40组，坚固板生产量约为150组，当然也包括大量的其他资源，比如石头，平滑石，原木等

另外，广安路网也连接到了下界交通，便于与赛博工业区主城区，经典半岛梦始区，南山区等地进行紧密联系和商贸往来

tips：如何正确使用北方工业区广安区的传送门？若想进入下界交通，请使用满速锟压机内的传送门

截至目前，梦始区为广安区提供玫瑰石英，是电子管的原料，南山区为广安区提供石材，末地特区则提供混凝土，经北方工业区加工，大多用于北方工业区本土工业建设

服务器目前将广安建设作为最高优先级，当广安缺货时，立刻从经典半岛获取货物并运输至广安，当建材冗余时，广安建材也会流入经典半岛'''),
                              SubTitleText("第三章 建筑"),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''广安区正在以一空双线的精神，不断发展建筑产业

广安区的道路已经迎来全面升级，并且真正通车

可以通车的道路有：北工大街，域南路

同时域南路也是第1个按照服务器车道级交通交通规范设计的道路（北工大街相当于在模组前就有了，模组后对其进行改造）

其他建筑方面，我们也在复原其他建筑，争取汇集各大产业尖端成果

后期，这些建筑将会投入湖山区的建设中

同时我们也在自主研发各式居民楼，建立现代的城市天际线，目前一期工程已经开始施工'''),
                              SubTitleText("第四章 问题与解决措施"),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''广安区目前出现了部分烂尾（特指八核刷铁机）情况，并且还出现玩家动力不足，过于杂乱等情况

针对此类问题，我们应该推行一空双线，定下新的目标，改善原有产业，增设新的产业，并且为其奋斗

并且，广安也在稳步前进，预计暑假将整理已有器械，并且通过它向核心三大区发展注入动力

或许暑假会将这里堆放的物资全部投入湖山全物品'''), 
                              SubTitleText("第五章 结论"),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''我们应当优化广安的结构，在核心三大区发展之前继续奠定其重工业中心地步

同时也应当把机会留给核心工业区，赛博工业区，湖山工业区

也应当发挥该区域的辐射带动作用，积极为其他区创造需求，带动其他区经济发展'''),
                              SubTitleText("附录1 目前的建筑总览"),
                              Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''首建:

刷铁机
自动熔炉
村民繁殖机
自动树场
机械动力中心
高速锟压产线
高速搅拌炉
高速鼓风机
北工大街

在建:

八核刷铁机
GDTC
域南路
广安区1期住宅楼计划
复制建筑
Wolf_359的小木屋（原南山）
CCCP_Kepler64A的小房子（原南新）
猫猫雕像（原南新）

其他:

无记录'''),
                            SubTitleText("附录2 “一空双线”理念"),
                            Divider(
                              color: Color.fromARGB(95, 0, 0, 0),
                              ),
                              NormalText('''“一空双线”，即“一个空置域、两个发展路线”

发展路线：
主要分为工业和建筑类两大主要路线，故称“双线”

工业路线：
通过发展工业以达到全产业链自给自足

建筑路线：
通过新区域的建设，使服务器变得更美观，同时也适于拍摄宣传片


''')
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                    Container(
                    margin: EdgeInsets.only(top: 50), 
                    child: MyBottomBavigationBar(),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}