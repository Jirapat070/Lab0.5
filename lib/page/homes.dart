import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  final _stdidController = TextEditingController();
  final _stdnameController = TextEditingController();
  final _majorController = TextEditingController();

  String? _selectedFaculty;
  String? _selectedYear;

  final List<String> _advisors = [
    "อาจารย์ คณิดา สินไหม",
    "อาจารย์ กฤษ ทองขุนดำ",
    "อาจารย์ อาจารี นาโค",
    "อาจารย์ วิสิทธิ์ บุญชุม",
    "อาจารย์ สุวิมล จุงจิตร",
    "อาจารย์ ณภัทร แก้วภิบาล",
  ];
  Map<String, bool> _selectedAdvisors = {};

  @override
  void initState() {
    super.initState();
    for (var advisor in _advisors) {
      _selectedAdvisors[advisor] = false;
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return 'กรุณากรอก$label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 192, 211),
      appBar: AppBar(
        title: Text("แบบฟอร์มข้อมูลนิสิต"),
        backgroundColor: const Color.fromARGB(255, 137, 155, 255),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ข้อมูลนิสิต", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      _buildTextField("รหัสนิสิต", _stdidController),
                      SizedBox(height: 16),
                      _buildTextField("ชื่อ-นามสกุล", _stdnameController),
                      SizedBox(height: 16),

                      Text("คณะ", style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                        value: _selectedFaculty,
                        items: [
                          'วิทยาศาสตร์และนวัตกรรมดิจิทัล',
                          'วิศวกรรมศาสตร์',
                          'วิทยาศาสตร์และการกีฬา',
                          'MUSE',
                          'ศึกษาศาสตร์',
                          'พยาบาลศาสตร์',
                        ].map((faculty) {
                          return DropdownMenuItem(
                            value: faculty,
                            child: Text(faculty),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFaculty = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณาเลือกคณะ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      _buildTextField("สาขา", _majorController),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ชั้นปี", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ...["1", "2", "3", "4"].map((year) {
                        return RadioListTile<String>(
                          title: Text("ชั้นปีที่ $year"),
                          value: year,
                          groupValue: _selectedYear,
                          onChanged: (value) {
                            setState(() {
                              _selectedYear = value!;
                            });
                          },
                        );
                      }).toList(),
                      if (_selectedYear == null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text("กรุณาเลือกชั้นปี", style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("อาจารย์ที่ปรึกษา", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ..._advisors.map((advisor) {
                        return CheckboxListTile(
                          title: Text(advisor),
                          value: _selectedAdvisors[advisor],
                          onChanged: (value) {
                            setState(() {
                              _selectedAdvisors[advisor] = value!;
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formkey.currentState!.validate() && _selectedYear != null) {
                      List<String> selectedAdvisors = _selectedAdvisors.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .toList();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("ข้อมูลนิสิต"),
                          content: SingleChildScrollView(
                            child: Text(
                              '''
รหัสนิสิต: ${_stdidController.text}
ชื่อ-นามสกุล: ${_stdnameController.text}
คณะ: $_selectedFaculty
สาขา: ${_majorController.text}
ชั้นปี: $_selectedYear
อาจารย์ที่ปรึกษา: ${selectedAdvisors.isNotEmpty ? selectedAdvisors.join(", ") : "ไม่มี"}
                              ''',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("ปิด"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text("บันทึกข้อมูล", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 111, 133, 255),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
