import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gweiland_flutter_task/model/crypto_model/crypto_model.dart';
import 'package:gweiland_flutter_task/viewmodel/api_services.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller for the search bar
  TextEditingController searchController = TextEditingController();
//our linechart bar data
  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53),
    ChartData(2011, 9.5),
    ChartData(2012, 10),
    ChartData(2013, 9.4),
    ChartData(2014, 1.8),
    ChartData(2015, 5.9),
    ChartData(2016, 3.5),
    ChartData(2017, 3.6),
    ChartData(2018, 7.43),
  ];
  // Default filter for sorting
  String selectedFilter = 'Rank';

  // Instance of ApiServices for fetching data
  late ApiServices apiServices;

  // Stream for listening to crypto data updates
  late Stream<CryptoModel> cryptoStream;

  // Model to hold crypto data
  CryptoModel? cryptoModel;

  // Initialize and apply sorting logic
  void applySorting() {
    // Sorting logic based on the selected filter
    switch (selectedFilter) {
      case 'Price':
        // Sort by price
        cryptoModel?.data?.sort((a, b) =>
            (a.quote?.usd?.price ?? 0).compareTo(b.quote?.usd?.price ?? 0));
        break;
      case 'Volume_24h':
        // Sort by volume_24h
        cryptoModel?.data?.sort((a, b) => (a.quote?.usd?.volume24h ?? 0)
            .compareTo(b.quote?.usd?.volume24h ?? 0));
        break;
      case 'Rank':
        // Sort by CMC rank
        cryptoModel?.data
            ?.sort((a, b) => (a.cmcRank ?? 0).compareTo(b.cmcRank ?? 0));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    apiServices = ApiServices();
    cryptoStream = apiServices.cryptoStream;
    apiServices.fetchCryptoData();
    applySorting();
  }

  @override
  void dispose() {
    apiServices.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: screensize.height * 0.11,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "EXCHANGES",
            style: GoogleFonts.inter(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        actions: [
          Row(
            children: [
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: -5, end: 0),
                badgeStyle: const badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  badgeColor: Colors.amber,
                ),
                child: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              SizedBox(width: screensize.width * 0.03),
              const Icon(Icons.settings, size: 28, color: Colors.black),
              SizedBox(width: screensize.width * 0.08)
            ],
          )
        ],
      ),
      /// used stream builder for continues data flow
      body: StreamBuilder<CryptoModel>(
        stream: cryptoStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cryptoModel = snapshot.data;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: screensize.height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screensize.width * 0.06,
                      ),

                      //**************_______Search field for searching cryptocurrency___________******************************** */
                      Container(
                        height: screensize.height * 0.055,
                        width: screensize.width * 0.6,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: const Offset(12, 26),
                              blurRadius: 50,
                              spreadRadius: 0,
                              color: Colors.grey.withOpacity(.1)),
                        ]),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            //search
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 17,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(11, 11, 11, 0.05),
                            hintText: "Search Cryptocurrency",
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey, fontSize: 13),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screensize.width * 0.04),
                      // **************___________________filter menu_______________________***************************
                      Container(
                        width: screensize.width * 0.25,
                        height: screensize.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Icon(
                                  Icons.filter_list,
                                  size: 16,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: [
                              'Rank',
                              'Price',
                              'Volume_24h',
                            ]
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedFilter,
                            onChanged: (String? value) {
                              setState(() {

                                selectedFilter = value!;
                                applySorting();
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              // height: 100,
                              // width: 130,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                              ),
                              elevation: 0,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 30,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      )
                      // _____________**************************___________________
                    ],
                  ),


                  //************_____________________Header______________________*****************
                  SizedBox(
                    width: screensize.width,
                    height: screensize.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screensize.width * 0.06,
                        ),
                        Text(
                          "Cryptocurrency",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0A0A0A),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screensize.width * 0.06,
                        ),
                        Text(
                          "NFT",
                          style: GoogleFonts.inter(
                            color: const Color(0x4C0A0A0A),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                   // _____________**************************___________________

                  //  *********************_________________________First position of CryptoCurrency container_________****************
                  Container(
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(97, 202, 233, 228),
                        borderRadius: BorderRadius.circular(15)),
                    height: 150,
                    child: Column(
                      children: [
                        SizedBox(
                          width: screensize.width * 0.8,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                leading: (Image.network(
                                  "https://s2.coinmarketcap.com/static/img/coins/64x64/${cryptoModel?.data?[0].id}.png",
                                )),
                                title: Text(
                                  "${cryptoModel?.data?[0].symbol}",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  "${cryptoModel?.data?[0].name}",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Column(
                                  children: [
                                    SizedBox(
                                      height: screensize.height * 0.01,
                                    ),
                                    Text(
                                      "\$${cryptoModel?.data?[0].quote?.usd!.price?.round()} USD",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Text(
                                          "${cryptoModel?.data?[0].quote?.usd!.percentChange24h.toString().substring(0, 4)}%",
                                          style: GoogleFonts.inter(
                                            color: (cryptoModel
                                                            ?.data?[0]
                                                            .quote
                                                            ?.usd!
                                                            .percentChange24h ??
                                                        1) <
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ), // _____________**************************___________________
                        

                        // *************__________Graph__________***********
                        Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                          height: screensize.height/13,
                        width: screensize.width*0.8,
                          child: 
                           AspectRatio(
          aspectRatio: 1.5,
          child: ClipRRect(borderRadius: BorderRadius.circular(15),
            child: LineChart(LineChartData(
                minX: 0,
                minY: 0,
                maxX: 11,
                maxY: 6,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: const [
                        FlSpot(0, 3.5),
                        FlSpot(1, 2),
                        FlSpot(2, 3),
                        FlSpot(2.8, 2.5),
                        FlSpot(3.4, 3),
                        FlSpot(4.6, 4.3),
                        FlSpot(5.2, 1.8),
                        FlSpot(6.2, 2.8),
                        FlSpot(7, 3),
                        FlSpot(8, 2),
                        FlSpot(9, 3.5),
                        FlSpot(10, 2),
                        FlSpot(11, 5),
                      ],
                      color: const Color.fromRGBO(21, 181, 27, 1),
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      isCurved: true,
                      curveSmoothness: 0.4,
                      belowBarData: BarAreaData(show: true,
                        color:  const Color.fromRGBO(0, 206, 8, 1) )
                      )
                ])),
          ),
        ),
                        ),
                      ],
                    ),
                  ), // _____________**************************___________________


                  SizedBox(
                    height: screensize.height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Top CryptoCurrencies",
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0A0A0A),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: screensize.width * 0.01),
                        Text(
                          "View All",
                          style: GoogleFonts.inter(
                            color: const Color(0x7F0B0B0B),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),

                  // ***************____________Crypto item listview builder_________****************
                  SizedBox(
                    height: screensize.height * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 19,
                      itemBuilder: (context, index) {
                        final upindex = index + 1;

                        return ListTile(
                          leading: Image.network(
                              "https://s2.coinmarketcap.com/static/img/coins/64x64/${cryptoModel?.data?[upindex].id}.png"),
                          title: Row(
                            children: [
                              Text(
                                "${cryptoModel?.data?[upindex].symbol}  ",
                                style: GoogleFonts.inter(
                                  color: Colors.black
                                      .withOpacity(0.8999999761581421),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: ((cryptoModel?.data?[upindex].quote?.usd!
                                                .percentChange24h ??
                                            1) <
                                        0)
                                    ? Image.asset("assets/graph_negative.png")
                                    : Image.asset("assets/graph_positive.png"),
                              )
                            ],
                          ),
                          subtitle: Text(
                            "${cryptoModel?.data?[upindex].name}",
                            style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${cryptoModel?.data?[upindex].quote?.usd!.price?.round()} USD",
                                style: GoogleFonts.inter(
                                  color: Colors.black
                                      .withOpacity(0.8999999761581421),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "${cryptoModel?.data?[upindex].quote?.usd!.percentChange24h.toString().substring(0, 4)}%",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: (cryptoModel?.data?[upindex].quote
                                                    ?.usd!.percentChange24h ??
                                                1) <
                                            0
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ) // _____________**************************___________________
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ), // _____________**************************___________________



      //  *********** custome bottom navigation bar **********_____________
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: Container(
        height: screensize.height * 0.14,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          margin:
              const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 10),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 70,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/e_shop.png",
                        scale: 4,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "€-\$shop",
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color:
                                Colors.white.withOpacity(0.4000000059604645)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/exchange.png",
                      color: Colors.grey.shade600,
                      scale: 4,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Exchange",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.4000000059604645)),
                    )
                  ],
                ),
              ),
              Image.asset(
                "assets/meta.png",
                scale: 70,
              ),
              SizedBox(
                height: 70,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/launchpads.png",
                      scale: 4,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Launchpads",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.4000000059604645)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/wallet.png",
                      scale: 4,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Wallet",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.4000000059604645)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ), // _____________**************************___________________
    );
  }
}

// graph data

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final int x;
  final double y;
}
