import 'package:u_traffic_enforcer/pages/common/bottom_nav.dart';
import '../../config/utils/exports.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget userNav() {
    final enforcer = ref.watch(enforcerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: USpace.space16,
      ),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              height: 36,
              width: 36,
              imageUrl: enforcer.photoUrl,
            ),
          ),
          const SizedBox(width: USpace.space16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${enforcer.firstName} ${enforcer.lastName}",
                style: const UTextStyle().textlgfontbold.copyWith(
                      color: UColors.gray700,
                    ),
              ),
              Text(
                enforcer.email,
                style: const UTextStyle()
                    .textxsfontsemibold
                    .copyWith(color: UColors.gray500),
              ),
            ],
          ),
          const Spacer(),
          // NotificationBellButton(
          //   scaffoldKey: _scaffoldKey,
          // ),
        ],
      ),
    );
  }

  Widget viewScheduleBtn() {
    return TextButton(
      onPressed: () {},
      child: const Text("View Schedule"),
    );
  }

  Widget miniDashboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: USpace.space16,
      ),
      child: Container(
        padding: const EdgeInsets.all(USpace.space12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USpace.space12),
          color: UColors.gray100,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Shift",
                  style: const UTextStyle().textxsfontnormal.copyWith(
                        color: UColors.gray600,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      "On Duty",
                      style: const UTextStyle().textxsfontnormal.copyWith(
                            color: UColors.green500,
                          ),
                    ),
                    const SizedBox(width: USpace.space4),
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: UColors.green500,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: USpace.space8),
            Container(
              decoration: BoxDecoration(
                color: UColors.blue600,
                borderRadius: BorderRadius.circular(USpace.space8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Oct 26",
                          style: const UTextStyle().textxlfontmedium.copyWith(
                                color: UColors.white,
                              ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(USpace.space8),
                              decoration: BoxDecoration(
                                color: UColors.white,
                                borderRadius:
                                    BorderRadius.circular(USpace.space8),
                              ),
                              child: Text(
                                "1:00 PM",
                                style: const UTextStyle()
                                    .textbasefontmedium
                                    .copyWith(
                                      color: UColors.gray600,
                                    ),
                              ),
                            ),
                            const SizedBox(width: USpace.space12),
                            Text(
                              "to",
                              style: const UTextStyle()
                                  .textbasefontmedium
                                  .copyWith(
                                    color: UColors.white,
                                  ),
                            ),
                            const SizedBox(width: USpace.space12),
                            Container(
                              padding: const EdgeInsets.all(USpace.space8),
                              decoration: BoxDecoration(
                                color: UColors.white,
                                borderRadius:
                                    BorderRadius.circular(USpace.space8),
                              ),
                              child: Text(
                                "9:00 PM",
                                style: const UTextStyle()
                                    .textbasefontmedium
                                    .copyWith(
                                      color: UColors.gray600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: USpace.space12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: UColors.white,
                          size: USpace.space28,
                        ),
                        const SizedBox(width: USpace.space8),
                        Text(
                          "Post 1",
                          style: const UTextStyle().textbasefontmedium.copyWith(
                                color: UColors.white,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: USpace.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Shift Rotation",
                      style: const UTextStyle().textxsfontnormal.copyWith(
                            color: UColors.gray600,
                          ),
                    ),
                    const SizedBox(height: USpace.space4),
                    Text(
                      "November 2, 2023",
                      style: const UTextStyle().textlgfontbold.copyWith(
                            color: UColors.blue700,
                          ),
                    ),
                  ],
                ),
                viewScheduleBtn(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget viewAllBtn() {
    return TextButton(
      onPressed: () {},
      child: const Text("View All"),
    );
  }

  Widget recentTicketsList() {
    final enforcer = ref.watch(enforcerProvider);

    return Expanded(
      child: ref.watch(getTicketsByEnforcerIdStream(enforcer.id)).when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              Ticket ticket = data[index];
              return ListTile(
                title: Text(
                  'Ticket # ${ticket.ticketNumber!.toString()}',
                  style: const UTextStyle().textbasefontmedium.copyWith(
                        color: UColors.gray700,
                      ),
                ),
                subtitle: Text(ticket.driverName!),
                onTap: () {
                  viewRecentTicket(ticket, context);
                },
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              'Error fetching tickets',
              style: const UTextStyle().textbasefontmedium.copyWith(
                    color: UColors.gray700,
                  ),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget recentTicketView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: USpace.space16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: USpace.space16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Tickets",
                style: const UTextStyle().textbasefontnormal.copyWith(
                      color: UColors.gray500,
                    ),
              ),
              const Spacer(),
            ],
          ),
          recentTicketsList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(violationsListProvider);
    ref.watch(vehicleTypeProvider);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: USpace.space16),
            userNav(),
            const SizedBox(height: USpace.space16),
            miniDashboard(),
            const SizedBox(height: USpace.space8),
            Expanded(
              child: recentTicketView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showMenu,
        label: const Text("Create Ticket"),
        icon: const Icon(Icons.add),
      ),
      endDrawer: const NotificationDrawer(),
      bottomNavigationBar: const BottomNav(),
    );
  }

  void showMenu() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(USpace.space16),
            decoration: BoxDecoration(
              color: UColors.white,
              borderRadius: BorderRadius.circular(USpace.space12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ElevatedButton.icon(
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.all(USpace.space24),
                //   ),
                //   onPressed: () async {
                //     Navigator.of(context).pop();
                //     String barcodeScanRes =
                //         await FlutterBarcodeScanner.scanBarcode(
                //       '#ff6666',
                //       'Cancel',
                //       true,
                //       ScanMode.QR,
                //     );

                //     QRDetails qrDetails = QRDetails.fromJson(
                //       jsonDecode(barcodeScanRes),
                //     );

                //     goCreateTicketWithLicense(qrDetails);
                //   },
                //   label: const Text("Scan QR"),
                //   icon: const Icon(Icons.qr_code_scanner_outlined),
                // ),
                // const SizedBox(height: USpace.space12),
                ElevatedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(USpace.space24),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    goCreateTicket();
                  },
                  label: const Text("Fill Form"),
                  icon: const Icon(Icons.create_rounded),
                ),
                const SizedBox(height: USpace.space12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void goCreateTicketWithLicense(QRDetails qrDetails) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateTicketPage(
          qrDetails: qrDetails,
        ),
      ),
    );
  }
}
