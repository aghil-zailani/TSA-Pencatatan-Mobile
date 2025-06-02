import 'apar_barang_jadi_screen.dart'; // Pastikan ini benar
import 'apar_sparepart_screen.dart'; // Pastikan ini benar
import 'hydrant_barang_jadi_screen.dart'; // Pastikan ini benar
import 'hydrant_sparepart_screen.dart'; // Pastikan ini benar
import 'barang_keluar_screen.dart'; // Pastikan ini benar
import '../widgets/custom_button.dart'; // Tambahkan ini

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Barang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('APAR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => APARBarangJadiScreen()),
                    );
                  },
                  child: Text('Barang Jadi'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => APARSpartScreen()), // Periksa nama kelas ini
                    );
                  },
                  child: Text('Sparepart'),
                ),
              ],
            ),
            Text('Hydrant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HydrantBarangJadiScreen()),
                    );
                  },
                  child: Text('Barang Jadi'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HydrantSparepartScreen()),
                    );
                  },
                  child: Text('Sparepart'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarangKeluarScreen()),
                );
              },
              child: Text('Barang Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}