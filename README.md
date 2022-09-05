# iOSArchive

this is the iOS App for my current project called <a href="https://github.com/BottyIvan/Archivio">Archive</a>

is build with SwiftUI and Swift, actually i'm currently learning this language, but this is what i've got.

# HOW THIS IS WORK

actually is pretty simple, there is a webservices (made in PHP and MYSQLI), tha app make a httpRequest and the callback is a JSON file that gives back the items
<br>
<br>
sample of the main:
<pre>
header('Content-Type: application/json; charset=utf-8');
session_start();

require_once "commons/connection.php";

$username = $_POST["username"];
$password = $_POST["password"];

$action = $_POST['action'];

require_once "auth/login.php";
if ($response['error'] == 0):
    switch ($action):
        case 'fetch':
            require_once "method/fetch_all.php";
            break;
        case 'update':
            require_once "method/update.php";    
        default:
            require_once "method/fetch_all.php";
            break;
    endswitch;
endif;

echo json_encode($response, JSON_PRETTY_PRINT);
</pre>

sample of the fetch case: method/fetch_all.php :
<pre>
$sql = "SELECT *,(SELECT image FROM archive_item_image WHERE id_archive = archive.id) AS image FROM archive";
if(!isset($_POST['all'])):
    switch($_POST['search']):
        case (is_numeric($_POST['search'])):
            $sql .= " WHERE id = ".$_POST['search'];
            break;
        case (!is_numeric($_POST['search'])):
            $sql .= " WHERE name LIKE '%".$_POST['search']."%' OR description LIKE '%".$_POST['search']."%'";
            break;
        case (!is_numeric($_POST['type'])):
            $sql .= " WHERE type LIKE '".$_POST['type']."'";
            break;
    endswitch;
endif;
if ($sql != "" OR !is_null($sql)):
    $sql .= " ORDER BY date DESC";
endif;
$result = mysqli_query($GLOBALS["connection"],$sql);
while($row = mysqli_fetch_array($result,MYSQLI_ASSOC)):
    $image = substr($row['image'],2);
    $itmes['idItem'] = $row['id'];
    $itmes['nameItem'] = $row['name'];
    $itmes['descriptionItem'] = $row['description'];
    $itmes['prizeItem'] = (Double) $row['prize'];
    $itmes['imageItem'] = $image;
    $itmes['statusItem'] = $row['status'];
    $itmes['quantityItem'] = (Int) $row['quantity'];
    $itmes['positionItem'] = $row['position'];
    $itmes['codeItem'] = $row['item_code'];
    $itmes['availableItem'] = (Bool) $row['available'];
    $itmes['basketItem'] = $row['basket'];
    $itmes['typeItem'] = $row['type'];
    $response['item'][] = $itmes;
endwhile;
</pre>

## THIS PROJECT WAS CREATED WITH THIS HELP

Build Your Own Blog App With SwiftUI : https://medium.com/p/3ee8196ecb84<br>
Drop shadows : https://morioh.com/p/973148290ab8<br>
The Complete Guide to NavigationView in SwiftUI : https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui<br>
Styling List Views : https://peterfriese.dev/posts/swiftui-listview-part3/<br>
How to add bar items to a navigation view : https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-bar-items-to-a-navigation-view<br>
How to present a Bottom Sheet in iOS 15 with UISheetPresentationController : https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/<br>
Building a login screen using modal views in SwiftUI : https://medium.com/geekculture/building-a-login-screen-using-modal-views-in-swiftui-f85915bbfb09<br>
Working with UserDefaults in Swift : https://www.appypie.com/userdefaults-swift-setting-getting-data-how-to<br>
Advanced Error Handling in Swift 5 : https://levelup.gitconnected.com/advanced-error-handling-in-swift-5-38795c30b7c<br>
Parsing JSON using the Codable protocol : https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol<br>
How to respond to view lifecycle events: onAppear() and onDisappear() : https://www.hackingwithswift.com/quick-start/swiftui/how-to-respond-to-view-lifecycle-events-onappear-and-ondisappear<br>
SwiftUI 5.5 API Data to List View : https://paulallies.medium.com/swiftui-5-5-api-data-to-list-view-776c69a456d3<br>
How to Fetch data from APIs in SwiftUI : https://medium.com/swlh/fetch-data-from-apis-in-swiftui-74b4b50f20e9<br>
HTTP Post Requests in Swift for beginners : https://developer.apple.com/forums/thread/666662<br>
NavigationLink View in .toolbar(...): unwanted nested child views on model change : https://www.hackingwithswift.com/forums/swiftui/navigationlink-view-in-toolbar-unwanted-nested-child-views-on-model-change/9844<br>
Quick guide on toolbars in SwiftUI : https://tanaschita.com/20220509-quick-quide-on-toolbars-in-swiftui/<br>
SOLVED: Swift ErrorNo exact matches in call to instance method 'appendInterpolation' : https://www.hackingwithswift.com/forums/swiftui/swift-error-no-exact-matches-in-call-to-instance-method-appendinterpolation/10472
How to format a TextField for numbers : https://www.hackingwithswift.com/quick-start/swiftui/how-to-format-a-textfield-for-numbers<br>
How to create a toggle switch : https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toggle-switch<br>
Stretchy Header And Parallax Scrolling In SwiftUI : https://blckbirds.com/post/stretchy-header-and-parallax-scrolling-in-swiftui/<br>
Adding settings to your iOS app : https://abhimuralidharan.medium.com/adding-settings-to-your-ios-app-cecef8c5497<br>
