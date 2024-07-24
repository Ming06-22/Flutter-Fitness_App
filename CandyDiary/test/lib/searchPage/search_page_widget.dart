import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test/database/sqfilite_db.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({
    Key? key,
    this.searchName,
  }) : super(key: key);

  final List<String>? searchName;

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> queryFoods = [];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

    _model.textController ??= TextEditingController();
    refreshData();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future<void> refreshData() async {
    final f = await DatabaseHelper.getFoodDB();
    setState(() {
      productList = f;
    });

  }
  void search(String keyword) async{
    final suggestions = productList.where((food) {
      final foodTitle = food['name'];
      final input = keyword;
      return foodTitle.contains(input);
    }).toList();
    setState(() => queryFoods = suggestions);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Color(0xFF3C2E92),
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFFD4D4DC),
                  size: 30,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
              child: TextFormField(
                controller: _model.textController,
                onChanged: search,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Search products...',
                  labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF57636C),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF57636C),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: null,
                validator: _model.textControllerValidator.asValidator(context),
              ),

            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: 100,
            elevation: 0,
          ),
        ),
        body: ListView.builder(
                shrinkWrap: true,
                itemCount: queryFoods.length,
                itemBuilder: (context, index) {
                  final food = queryFoods[index];
                  return ListTile(
                    title: Text(food['name'],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF090404),
                        fontSize: 16,
                      ),),

                    onTap: () async {
                      context.pushNamed('nutrient', queryParams: food.map((key, value) =>
                          MapEntry(key, value.toString())).withoutNulls);
                    },
                  );
                },
              ),
      ),
    );
  }
}
