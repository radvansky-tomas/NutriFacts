//  Created by Tomas Radvansky on 21/01/2015.
//  Copyright (c) 2015 Tomas Radvansky. All rights reserved.//
import UIKit

//Icomoon enumeration
enum MoonIcons:String {case home = "\u{e900}"
    case home2 = "\u{e901}"
    case home3 = "\u{e902}"
    case office = "\u{e903}"
    case newspaper = "\u{e904}"
    case pencil = "\u{e905}"
    case pencil2 = "\u{e906}"
    case quill = "\u{e907}"
    case pen = "\u{e908}"
    case blog = "\u{e909}"
    case eyedropper = "\u{e90a}"
    case droplet = "\u{e90b}"
    case paint_format = "\u{e90c}"
    case image = "\u{e90d}"
    case images = "\u{e90e}"
    case camera = "\u{e90f}"
    case headphones = "\u{e910}"
    case music = "\u{e911}"
    case play = "\u{e912}"
    case film = "\u{e913}"
    case video_camera = "\u{e914}"
    case dice = "\u{e915}"
    case pacman = "\u{e916}"
    case spades = "\u{e917}"
    case clubs = "\u{e918}"
    case diamonds = "\u{e919}"
    case bullhorn = "\u{e91a}"
    case connection = "\u{e91b}"
    case podcast = "\u{e91c}"
    case feed = "\u{e91d}"
    case mic = "\u{e91e}"
    case book = "\u{e91f}"
    case books = "\u{e920}"
    case library = "\u{e921}"
    case file_text = "\u{e922}"
    case profile = "\u{e923}"
    case file_empty = "\u{e924}"
    case files_empty = "\u{e925}"
    case file_text2 = "\u{e926}"
    case file_picture = "\u{e927}"
    case file_music = "\u{e928}"
    case file_play = "\u{e929}"
    case file_video = "\u{e92a}"
    case file_zip = "\u{e92b}"
    case copy = "\u{e92c}"
    case paste = "\u{e92d}"
    case stack = "\u{e92e}"
    case folder = "\u{e92f}"
    case folder_open = "\u{e930}"
    case folder_plus = "\u{e931}"
    case folder_minus = "\u{e932}"
    case folder_download = "\u{e933}"
    case folder_upload = "\u{e934}"
    case price_tag = "\u{e935}"
    case price_tags = "\u{e936}"
    case barcode = "\u{e937}"
    case qrcode = "\u{e938}"
    case ticket = "\u{e939}"
    case cart = "\u{e93a}"
    case coin_dollar = "\u{e93b}"
    case coin_euro = "\u{e93c}"
    case coin_pound = "\u{e93d}"
    case coin_yen = "\u{e93e}"
    case credit_card = "\u{e93f}"
    case calculator = "\u{e940}"
    case lifebuoy = "\u{e941}"
    case phone = "\u{e942}"
    case phone_hang_up = "\u{e943}"
    case address_book = "\u{e944}"
    case envelop = "\u{e945}"
    case pushpin = "\u{e946}"
    case location = "\u{e947}"
    case location2 = "\u{e948}"
    case compass = "\u{e949}"
    case compass2 = "\u{e94a}"
    case map = "\u{e94b}"
    case map2 = "\u{e94c}"
    case history = "\u{e94d}"
    case clock = "\u{e94e}"
    case clock2 = "\u{e94f}"
    case alarm = "\u{e950}"
    case bell = "\u{e951}"
    case stopwatch = "\u{e952}"
    case calendar = "\u{e953}"
    case printer = "\u{e954}"
    case keyboard = "\u{e955}"
    case display = "\u{e956}"
    case laptop = "\u{e957}"
    case mobile = "\u{e958}"
    case mobile2 = "\u{e959}"
    case tablet = "\u{e95a}"
    case tv = "\u{e95b}"
    case drawer = "\u{e95c}"
    case drawer2 = "\u{e95d}"
    case box_add = "\u{e95e}"
    case box_remove = "\u{e95f}"
    case download = "\u{e960}"
    case upload = "\u{e961}"
    case floppy_disk = "\u{e962}"
    case drive = "\u{e963}"
    case database = "\u{e964}"
    case undo = "\u{e965}"
    case redo = "\u{e966}"
    case undo2 = "\u{e967}"
    case redo2 = "\u{e968}"
    case forward = "\u{e969}"
    case reply = "\u{e96a}"
    case bubble = "\u{e96b}"
    case bubbles = "\u{e96c}"
    case bubbles2 = "\u{e96d}"
    case bubble2 = "\u{e96e}"
    case bubbles3 = "\u{e96f}"
    case bubbles4 = "\u{e970}"
    case user = "\u{e971}"
    case users = "\u{e972}"
    case user_plus = "\u{e973}"
    case user_minus = "\u{e974}"
    case user_check = "\u{e975}"
    case user_tie = "\u{e976}"
    case quotes_left = "\u{e977}"
    case quotes_right = "\u{e978}"
    case hour_glass = "\u{e979}"
    case spinner = "\u{e97a}"
    case spinner2 = "\u{e97b}"
    case spinner3 = "\u{e97c}"
    case spinner4 = "\u{e97d}"
    case spinner5 = "\u{e97e}"
    case spinner6 = "\u{e97f}"
    case spinner7 = "\u{e980}"
    case spinner8 = "\u{e981}"
    case spinner9 = "\u{e982}"
    case spinner10 = "\u{e983}"
    case spinner11 = "\u{e984}"
    case binoculars = "\u{e985}"
    case search = "\u{e986}"
    case zoom_in = "\u{e987}"
    case zoom_out = "\u{e988}"
    case enlarge = "\u{e989}"
    case shrink = "\u{e98a}"
    case enlarge2 = "\u{e98b}"
    case shrink2 = "\u{e98c}"
    case key = "\u{e98d}"
    case key2 = "\u{e98e}"
    case lock = "\u{e98f}"
    case unlocked = "\u{e990}"
    case wrench = "\u{e991}"
    case equalizer = "\u{e992}"
    case equalizer2 = "\u{e993}"
    case cog = "\u{e994}"
    case cogs = "\u{e995}"
    case hammer = "\u{e996}"
    case magic_wand = "\u{e997}"
    case aid_kit = "\u{e998}"
    case bug = "\u{e999}"
    case pie_chart = "\u{e99a}"
    case stats_dots = "\u{e99b}"
    case stats_bars = "\u{e99c}"
    case stats_bars2 = "\u{e99d}"
    case trophy = "\u{e99e}"
    case gift = "\u{e99f}"
    case glass = "\u{e9a0}"
    case glass2 = "\u{e9a1}"
    case mug = "\u{e9a2}"
    case spoon_knife = "\u{e9a3}"
    case leaf = "\u{e9a4}"
    case rocket = "\u{e9a5}"
    case meter = "\u{e9a6}"
    case meter2 = "\u{e9a7}"
    case hammer2 = "\u{e9a8}"
    case fire = "\u{e9a9}"
    case lab = "\u{e9aa}"
    case magnet = "\u{e9ab}"
    case bin = "\u{e9ac}"
    case bin2 = "\u{e9ad}"
    case briefcase = "\u{e9ae}"
    case airplane = "\u{e9af}"
    case truck = "\u{e9b0}"
    case road = "\u{e9b1}"
    case accessibility = "\u{e9b2}"
    case target = "\u{e9b3}"
    case shield = "\u{e9b4}"
    case power = "\u{e9b5}"
    case power_cord = "\u{e9b7}"
    case clipboard = "\u{e9b8}"
    case list_numbered = "\u{e9b9}"
    case list = "\u{e9ba}"
    case list2 = "\u{e9bb}"
    case tree = "\u{e9bc}"
    case menu = "\u{e9bd}"
    case menu2 = "\u{e9be}"
    case menu3 = "\u{e9bf}"
    case menu4 = "\u{e9c0}"
    case cloud = "\u{e9c1}"
    case cloud_download = "\u{e9c2}"
    case cloud_upload = "\u{e9c3}"
    case cloud_check = "\u{e9c4}"
    case download2 = "\u{e9c5}"
    case upload2 = "\u{e9c6}"
    case download3 = "\u{e9c7}"
    case upload3 = "\u{e9c8}"
    case sphere = "\u{e9c9}"
    case earth = "\u{e9ca}"
    case link = "\u{e9cb}"
    case flag = "\u{e9cc}"
    case attachment = "\u{e9cd}"
    case eye = "\u{e9ce}"
    case eye_plus = "\u{e9cf}"
    case eye_minus = "\u{e9d0}"
    case eye_blocked = "\u{e9d1}"
    case bookmark = "\u{e9d2}"
    case bookmarks = "\u{e9d3}"
    case sun = "\u{e9d4}"
    case contrast = "\u{e9d5}"
    case brightness_contrast = "\u{e9d6}"
    case star_empty = "\u{e9d7}"
    case star_half = "\u{e9d8}"
    case star_full = "\u{e9d9}"
    case heart = "\u{e9da}"
    case heart_broken = "\u{e9db}"
    case man = "\u{e9dc}"
    case woman = "\u{e9dd}"
    case man_woman = "\u{e9de}"
    case happy = "\u{e9df}"
    case happy2 = "\u{e9e0}"
    case smile = "\u{e9e1}"
    case smile2 = "\u{e9e2}"
    case tongue = "\u{e9e3}"
    case tongue2 = "\u{e9e4}"
    case sad = "\u{e9e5}"
    case sad2 = "\u{e9e6}"
    case wink = "\u{e9e7}"
    case wink2 = "\u{e9e8}"
    case grin = "\u{e9e9}"
    case grin2 = "\u{e9ea}"
    case cool = "\u{e9eb}"
    case cool2 = "\u{e9ec}"
    case angry = "\u{e9ed}"
    case angry2 = "\u{e9ee}"
    case evil = "\u{e9ef}"
    case evil2 = "\u{e9f0}"
    case shocked = "\u{e9f1}"
    case shocked2 = "\u{e9f2}"
    case baffled = "\u{e9f3}"
    case baffled2 = "\u{e9f4}"
    case confused = "\u{e9f5}"
    case confused2 = "\u{e9f6}"
    case neutral = "\u{e9f7}"
    case neutral2 = "\u{e9f8}"
    case hipster = "\u{e9f9}"
    case hipster2 = "\u{e9fa}"
    case wondering = "\u{e9fb}"
    case wondering2 = "\u{e9fc}"
    case sleepy = "\u{e9fd}"
    case sleepy2 = "\u{e9fe}"
    case frustrated = "\u{e9ff}"
    case frustrated2 = "\u{ea00}"
    case crying = "\u{ea01}"
    case crying2 = "\u{ea02}"
    case point_up = "\u{ea03}"
    case point_right = "\u{ea04}"
    case point_down = "\u{ea05}"
    case point_left = "\u{ea06}"
    case warning = "\u{ea07}"
    case notification = "\u{ea08}"
    case question = "\u{ea09}"
    case plus = "\u{ea0a}"
    case minus = "\u{ea0b}"
    case info = "\u{ea0c}"
    case cancel_circle = "\u{ea0d}"
    case blocked = "\u{ea0e}"
    case cross = "\u{ea0f}"
    case checkmark = "\u{ea10}"
    case checkmark2 = "\u{ea11}"
    case spell_check = "\u{ea12}"
    case enter = "\u{ea13}"
    case exit = "\u{ea14}"
    case play2 = "\u{ea15}"
    case pause = "\u{ea16}"
    case stop = "\u{ea17}"
    case previous = "\u{ea18}"
    case next = "\u{ea19}"
    case backward = "\u{ea1a}"
    case forward2 = "\u{ea1b}"
    case play3 = "\u{ea1c}"
    case pause2 = "\u{ea1d}"
    case stop2 = "\u{ea1e}"
    case backward2 = "\u{ea1f}"
    case forward3 = "\u{ea20}"
    case first = "\u{ea21}"
    case last = "\u{ea22}"
    case previous2 = "\u{ea23}"
    case next2 = "\u{ea24}"
    case eject = "\u{ea25}"
    case volume_high = "\u{ea26}"
    case volume_medium = "\u{ea27}"
    case volume_low = "\u{ea28}"
    case volume_mute = "\u{ea29}"
    case volume_mute2 = "\u{ea2a}"
    case volume_increase = "\u{ea2b}"
    case volume_decrease = "\u{ea2c}"
    case loop = "\u{ea2d}"
    case loop2 = "\u{ea2e}"
    case infinite = "\u{ea2f}"
    case shuffle = "\u{ea30}"
    case arrow_up_left = "\u{ea31}"
    case arrow_up = "\u{ea32}"
    case arrow_up_right = "\u{ea33}"
    case arrow_right = "\u{ea34}"
    case arrow_down_right = "\u{ea35}"
    case arrow_down = "\u{ea36}"
    case arrow_down_left = "\u{ea37}"
    case arrow_left = "\u{ea38}"
    case arrow_up_left2 = "\u{ea39}"
    case arrow_up2 = "\u{ea3a}"
    case arrow_up_right2 = "\u{ea3b}"
    case arrow_right2 = "\u{ea3c}"
    case arrow_down_right2 = "\u{ea3d}"
    case arrow_down2 = "\u{ea3e}"
    case arrow_down_left2 = "\u{ea3f}"
    case arrow_left2 = "\u{ea40}"
    case circle_up = "\u{ea41}"
    case circle_right = "\u{ea42}"
    case circle_down = "\u{ea43}"
    case circle_left = "\u{ea44}"
    case tab = "\u{ea45}"
    case move_up = "\u{ea46}"
    case move_down = "\u{ea47}"
    case sort_alpha_asc = "\u{ea48}"
    case sort_alpha_desc = "\u{ea49}"
    case sort_numeric_asc = "\u{ea4a}"
    case sort_numberic_desc = "\u{ea4b}"
    case sort_amount_asc = "\u{ea4c}"
    case sort_amount_desc = "\u{ea4d}"
    case command = "\u{ea4e}"
    case shift = "\u{ea4f}"
    case ctrl = "\u{ea50}"
    case opt = "\u{ea51}"
    case checkbox_checked = "\u{ea52}"
    case checkbox_unchecked = "\u{ea53}"
    case radio_checked = "\u{ea54}"
    case radio_checked2 = "\u{ea55}"
    case radio_unchecked = "\u{ea56}"
    case crop = "\u{ea57}"
    case make_group = "\u{ea58}"
    case ungroup = "\u{ea59}"
    case scissors = "\u{ea5a}"
    case filter = "\u{ea5b}"
    case font = "\u{ea5c}"
    case ligature = "\u{ea5d}"
    case ligature2 = "\u{ea5e}"
    case text_height = "\u{ea5f}"
    case text_width = "\u{ea60}"
    case font_size = "\u{ea61}"
    case bold = "\u{ea62}"
    case underline = "\u{ea63}"
    case italic = "\u{ea64}"
    case strikethrough = "\u{ea65}"
    case omega = "\u{ea66}"
    case sigma = "\u{ea67}"
    case page_break = "\u{ea68}"
    case superscript = "\u{ea69}"
    case superscript2 = "\u{ea6b}"
    case subscript2 = "\u{ea6c}"
    case text_color = "\u{ea6d}"
    case pagebreak = "\u{ea6e}"
    case clear_formatting = "\u{ea6f}"
    case table = "\u{ea70}"
    case table2 = "\u{ea71}"
    case insert_template = "\u{ea72}"
    case pilcrow = "\u{ea73}"
    case ltr = "\u{ea74}"
    case rtl = "\u{ea75}"
    case section = "\u{ea76}"
    case paragraph_left = "\u{ea77}"
    case paragraph_center = "\u{ea78}"
    case paragraph_right = "\u{ea79}"
    case paragraph_justify = "\u{ea7a}"
    case indent_increase = "\u{ea7b}"
    case indent_decrease = "\u{ea7c}"
    case share = "\u{ea7d}"
    case new_tab = "\u{ea7e}"
    case embed = "\u{ea7f}"
    case embed2 = "\u{ea80}"
    case terminal = "\u{ea81}"
    case share2 = "\u{ea82}"
    case mail = "\u{ea83}"
    case mail2 = "\u{ea84}"
    case mail3 = "\u{ea85}"
    case mail4 = "\u{ea86}"
    case google = "\u{ea87}"
    case google_plus = "\u{ea88}"
    case google_plus2 = "\u{ea89}"
    case google_plus3 = "\u{ea8a}"
    case google_drive = "\u{ea8b}"
    case facebook = "\u{ea8c}"
    case facebook2 = "\u{ea8d}"
    case facebook3 = "\u{ea8e}"
    case ello = "\u{ea8f}"
    case instagram = "\u{ea90}"
    case twitter = "\u{ea91}"
    case twitter2 = "\u{ea92}"
    case twitter3 = "\u{ea93}"
    case feed2 = "\u{ea94}"
    case feed3 = "\u{ea95}"
    case feed4 = "\u{ea96}"
    case youtube = "\u{ea97}"
    case youtube2 = "\u{ea98}"
    case youtube3 = "\u{ea99}"
    case youtube4 = "\u{ea9a}"
    case twitch = "\u{ea9b}"
    case vimeo = "\u{ea9c}"
    case vimeo2 = "\u{ea9d}"
    case vimeo3 = "\u{ea9e}"
    case lanyrd = "\u{ea9f}"
    case flickr = "\u{eaa0}"
    case flickr2 = "\u{eaa1}"
    case flickr3 = "\u{eaa2}"
    case flickr4 = "\u{eaa3}"
    case picassa = "\u{eaa4}"
    case picassa2 = "\u{eaa5}"
    case dribbble = "\u{eaa6}"
    case dribbble2 = "\u{eaa7}"
    case dribbble3 = "\u{eaa8}"
    case forrst = "\u{eaa9}"
    case forrst2 = "\u{eaaa}"
    case deviantart = "\u{eaab}"
    case deviantart2 = "\u{eaac}"
    case steam = "\u{eaad}"
    case steam2 = "\u{eaae}"
    case dropbox = "\u{eaaf}"
    case onedrive = "\u{eab0}"
    case github = "\u{eab1}"
    case github2 = "\u{eab2}"
    case github3 = "\u{eab3}"
    case github4 = "\u{eab4}"
    case github5 = "\u{eab5}"
    case wordpress = "\u{eab6}"
    case wordpress2 = "\u{eab7}"
    case joomla = "\u{eab8}"
    case blogger = "\u{eab9}"
    case blogger2 = "\u{eaba}"
    case tumblr = "\u{eabb}"
    case tumblr2 = "\u{eabc}"
    case yahoo = "\u{eabd}"
    case tux = "\u{eabe}"
    case apple = "\u{eabf}"
    case finder = "\u{eac0}"
    case android = "\u{eac1}"
    case windows = "\u{eac2}"
    case windows8 = "\u{eac3}"
    case soundcloud = "\u{eac4}"
    case soundcloud2 = "\u{eac5}"
    case skype = "\u{eac6}"
    case reddit = "\u{eac7}"
    case linkedin = "\u{eac8}"
    case linkedin2 = "\u{eac9}"
    case lastfm = "\u{eaca}"
    case lastfm2 = "\u{eacb}"
    case delicious = "\u{eacc}"
    case stumbleupon = "\u{eacd}"
    case stumbleupon2 = "\u{eace}"
    case stackoverflow = "\u{eacf}"
    case pinterest = "\u{ead0}"
    case pinterest2 = "\u{ead1}"
    case xing = "\u{ead2}"
    case xing2 = "\u{ead3}"
    case flattr = "\u{ead4}"
    case foursquare = "\u{ead5}"
    case paypal = "\u{ead6}"
    case paypal2 = "\u{ead7}"
    case paypal3 = "\u{ead8}"
    case yelp = "\u{ead9}"
    case file_pdf = "\u{eada}"
    case file_openoffice = "\u{eadb}"
    case file_word = "\u{eadc}"
    case file_excel = "\u{eadd}"
    case libreoffice = "\u{eade}"
    case html5 = "\u{eadf}"
    case html52 = "\u{eae0}"
    case css3 = "\u{eae1}"
    case git = "\u{eae2}"
    case svg = "\u{eae3}"
    case codepen = "\u{eae4}"
    case chrome = "\u{eae5}"
    case firefox = "\u{eae6}"
    case IE = "\u{eae7}"
    case opera = "\u{eae8}"
    case safari = "\u{eae9}"
    case IcoMoon = "\u{eaea}"
    case refresh = "\u{e600}"
    case addPeople = "\u{e601}"
    case testAttraction = "\u{e608}"
    case backMenu = "\u{e609}"
    case unchecked = "\u{e60a}"
    case checked = "\u{e60b}"
    case unknownchecked = "\u{e60c}"
    case calendar2 = "\u{e60d}"
    case messages = "\u{e60e}"
    case check = "\u{e60f}"
    case check2 = "\u{e610}"
    case people = "\u{e612}"
    case credits = "\u{e613}"
    case edit = "\u{e616}"
    case fb = "\u{e617}"
    case flashpic = "\u{e618}"
    case delete = "\u{e619}"
    case gifts = "\u{e61a}"
    case attraction1 = "\u{e61b}"
    case attraction2 = "\u{e61c}"
    case kiss = "\u{e61d}"
    case back = "\u{e61e}"
    case lock3 = "\u{e620}"
    case lock2 = "\u{e621}"
    case mapMarker = "\u{e622}"
    case exit2 = "\u{e623}"
    case sidemenu = "\u{e624}"
    case rightArrowMenu = "\u{e626}"
    case uniE627 = "\u{e627}"
    case newMessage = "\u{e628}"
    case user1 = "\u{e629}"
    case camera1 = "\u{e62a}"
    case uniE62B = "\u{e62b}"
    case uniE62C = "\u{e62c}"
    case bin3 = "\u{e62d}"
    case deletePeople = "\u{e62e}"
    case rightArrow = "\u{e630}"
    case download4 = "\u{e631}"
    case save = "\u{e632}"
    case searchMenu = "\u{e633}"
    case seach2 = "\u{e634}"
    case lockmenu = "\u{e635}"
    case settings = "\u{e636}"
    case wine = "\u{e637}"
    case time = "\u{e638}"
    case male = "\u{e639}"
    case female = "\u{e63a}"
    case vip = "\u{e63b}"
    case visits = "\u{e63c}"
    case webcam = "\u{e63d}"
    case lock1 = "\u{e63e}"
    case lockChecked = "\u{e643}"
    case pending = "\u{e644}"
    case boosts = "\u{e645}"
    case invisible = "\u{e646}"
    case doubleAttraction = "\u{e61b}\u{e61c}"
    static let allValues = [home,
        home2,
        home3,
        office,
        newspaper,
        pencil,
        pencil2,
        quill,
        pen,
        blog,
        eyedropper,
        droplet,
        paint_format,
        image,
        images,
        camera,
        headphones,
        music,
        play,
        film,
        video_camera,
        dice,
        pacman,
        spades,
        clubs,
        diamonds,
        bullhorn,
        connection,
        podcast,
        feed,
        mic,
        book,
        books,
        library,
        file_text,
        profile,
        file_empty,
        files_empty,
        file_text2,
        file_picture,
        file_music,
        file_play,
        file_video,
        file_zip,
        copy,
        paste,
        stack,
        folder,
        folder_open,
        folder_plus,
        folder_minus,
        folder_download,
        folder_upload,
        price_tag,
        price_tags,
        barcode,
        qrcode,
        ticket,
        cart,
        coin_dollar,
        coin_euro,
        coin_pound,
        coin_yen,
        credit_card,
        calculator,
        lifebuoy,
        phone,
        phone_hang_up,
        address_book,
        envelop,
        pushpin,
        location,
        location2,
        compass,
        compass2,
        map,
        map2,
        history,
        clock,
        clock2,
        alarm,
        bell,
        stopwatch,
        calendar,
        printer,
        keyboard,
        display,
        laptop,
        mobile,
        mobile2,
        tablet,
        tv,
        drawer,
        drawer2,
        box_add,
        box_remove,
        download,
        upload,
        floppy_disk,
        drive,
        database,
        undo,
        redo,
        undo2,
        redo2,
        forward,
        reply,
        bubble,
        bubbles,
        bubbles2,
        bubble2,
        bubbles3,
        bubbles4,
        user,
        users,
        user_plus,
        user_minus,
        user_check,
        user_tie,
        quotes_left,
        quotes_right,
        hour_glass,
        spinner,
        spinner2,
        spinner3,
        spinner4,
        spinner5,
        spinner6,
        spinner7,
        spinner8,
        spinner9,
        spinner10,
        spinner11,
        binoculars,
        search,
        zoom_in,
        zoom_out,
        enlarge,
        shrink,
        enlarge2,
        shrink2,
        key,
        key2,
        lock,
        unlocked,
        wrench,
        equalizer,
        equalizer2,
        cog,
        cogs,
        hammer,
        magic_wand,
        aid_kit,
        bug,
        pie_chart,
        stats_dots,
        stats_bars,
        stats_bars2,
        trophy,
        gift,
        glass,
        glass2,
        mug,
        spoon_knife,
        leaf,
        rocket,
        meter,
        meter2,
        hammer2,
        fire,
        lab,
        magnet,
        bin,
        bin2,
        briefcase,
        airplane,
        truck,
        road,
        accessibility,
        target,
        shield,
        power,
        power_cord,
        clipboard,
        list_numbered,
        list,
        list2,
        tree,
        menu,
        menu2,
        menu3,
        menu4,
        cloud,
        cloud_download,
        cloud_upload,
        cloud_check,
        download2,
        upload2,
        download3,
        upload3,
        sphere,
        earth,
        link,
        flag,
        attachment,
        eye,
        eye_plus,
        eye_minus,
        eye_blocked,
        bookmark,
        bookmarks,
        sun,
        contrast,
        brightness_contrast,
        star_empty,
        star_half,
        star_full,
        heart,
        heart_broken,
        man,
        woman,
        man_woman,
        happy,
        happy2,
        smile,
        smile2,
        tongue,
        tongue2,
        sad,
        sad2,
        wink,
        wink2,
        grin,
        grin2,
        cool,
        cool2,
        angry,
        angry2,
        evil,
        evil2,
        shocked,
        shocked2,
        baffled,
        baffled2,
        confused,
        confused2,
        neutral,
        neutral2,
        hipster,
        hipster2,
        wondering,
        wondering2,
        sleepy,
        sleepy2,
        frustrated,
        frustrated2,
        crying,
        crying2,
        point_up,
        point_right,
        point_down,
        point_left,
        warning,
        notification,
        question,
        plus,
        minus,
        info,
        cancel_circle,
        blocked,
        cross,
        checkmark,
        checkmark2,
        spell_check,
        enter,
        exit,
        play2,
        pause,
        stop,
        previous,
        next,
        backward,
        forward2,
        play3,
        pause2,
        stop2,
        backward2,
        forward3,
        first,
        last,
        previous2,
        next2,
        eject,
        volume_high,
        volume_medium,
        volume_low,
        volume_mute,
        volume_mute2,
        volume_increase,
        volume_decrease,
        loop,
        loop2,
        infinite,
        shuffle,
        arrow_up_left,
        arrow_up,
        arrow_up_right,
        arrow_right,
        arrow_down_right,
        arrow_down,
        arrow_down_left,
        arrow_left,
        arrow_up_left2,
        arrow_up2,
        arrow_up_right2,
        arrow_right2,
        arrow_down_right2,
        arrow_down2,
        arrow_down_left2,
        arrow_left2,
        circle_up,
        circle_right,
        circle_down,
        circle_left,
        tab,
        move_up,
        move_down,
        sort_alpha_asc,
        sort_alpha_desc,
        sort_numeric_asc,
        sort_numberic_desc,
        sort_amount_asc,
        sort_amount_desc,
        command,
        shift,
        ctrl,
        opt,
        checkbox_checked,
        checkbox_unchecked,
        radio_checked,
        radio_checked2,
        radio_unchecked,
        crop,
        make_group,
        ungroup,
        scissors,
        filter,
        font,
        ligature,
        ligature2,
        text_height,
        text_width,
        font_size,
        bold,
        underline,
        italic,
        strikethrough,
        omega,
        sigma,
        page_break,
        superscript,
        superscript2,
        subscript2,
        text_color,
        pagebreak,
        clear_formatting,
        table,
        table2,
        insert_template,
        pilcrow,
        ltr,
        rtl,
        section,
        paragraph_left,
        paragraph_center,
        paragraph_right,
        paragraph_justify,
        indent_increase,
        indent_decrease,
        share,
        new_tab,
        embed,
        embed2,
        terminal,
        share2,
        mail,
        mail2,
        mail3,
        mail4,
        google,
        google_plus,
        google_plus2,
        google_plus3,
        google_drive,
        facebook,
        facebook2,
        facebook3,
        ello,
        instagram,
        twitter,
        twitter2,
        twitter3,
        feed2,
        feed3,
        feed4,
        youtube,
        youtube2,
        youtube3,
        youtube4,
        twitch,
        vimeo,
        vimeo2,
        vimeo3,
        lanyrd,
        flickr,
        flickr2,
        flickr3,
        flickr4,
        picassa,
        picassa2,
        dribbble,
        dribbble2,
        dribbble3,
        forrst,
        forrst2,
        deviantart,
        deviantart2,
        steam,
        steam2,
        dropbox,
        onedrive,
        github,
        github2,
        github3,
        github4,
        github5,
        wordpress,
        wordpress2,
        joomla,
        blogger,
        blogger2,
        tumblr,
        tumblr2,
        yahoo,
        tux,
        apple,
        finder,
        android,
        windows,
        windows8,
        soundcloud,
        soundcloud2,
        skype,
        reddit,
        linkedin,
        linkedin2,
        lastfm,
        lastfm2,
        delicious,
        stumbleupon,
        stumbleupon2,
        stackoverflow,
        pinterest,
        pinterest2,
        xing,
        xing2,
        flattr,
        foursquare,
        paypal,
        paypal2,
        paypal3,
        yelp,
        file_pdf,
        file_openoffice,
        file_word,
        file_excel,
        libreoffice,
        html5,
        html52,
        css3,
        git,
        svg,
        codepen,
        chrome,
        firefox,
        IE,
        opera,
        safari,
        IcoMoon,
        refresh,
        addPeople,
        testAttraction,
        backMenu,
        unchecked,
        checked,
        unknownchecked,
        calendar2,
        messages,
        check,
        check2,
        people,
        credits,
        edit,
        fb,
        flashpic,
        delete,
        gifts,
        attraction1,
        attraction2,
        kiss,
        back,
        lock3,
        lock2,
        mapMarker,
        exit2,
        sidemenu,
        rightArrowMenu,
        uniE627,
        newMessage,
        user1,
        camera1,
        uniE62B,
        uniE62C,
        bin3,
        deletePeople,
        rightArrow,
        download4,
        save,
        searchMenu,
        seach2,
        lockmenu,
        settings,
        wine,
        time,
        male,
        female,
        vip,
        visits,
        webcam,
        lock1,
        lockChecked,
        pending,
        boosts,
        invisible,
        doubleAttraction]
}


//MARK: Daily income per item
let RTotalFat:Int =	65 //(g)
let RSaturatedFat:Int = 20 //g
let RCholesterol:Int = 300 //milligrams (mg)
let RSodium:Double	= 2.4 //mg
let RPotassium:Double = 3.5 //mg
let RTotalCarbohydrate:Int = 300 //g
let RDietaryFiber:Int =	25 //g
let RProtein:Int = 50 //g
//Vitamin A	5,000 International Units (IU)
//Vitamin C	60 mg
//Calcium	1,000 mg
//Iron	18 mg
//Vitamin D	400 IU
//Vitamin E	30 IU
//Vitamin K	80 micrograms µg
//Thiamin	1.5 mg
//Riboflavin	1.7 mg
//Niacin	20 mg
//Vitamin B6	2 mg
//Folate	400 µg
//Vitamin B12	6 µg
//Biotin	300 µg
//Pantothenic acid	10 mg
//Phosphorus	1,000 mg
//Iodine	150 µg
//Magnesium	400 mg
//Zinc	15 mg
//Selenium	70 µg
//Copper	2 mg
//Manganese	2 mg
//Chromium	120 µg
//Molybdenum	75 µg
//Chloride	3,400 mg


class Globals: NSObject {
    //MARK: Icomoon helper functions
    class func GetMoonIcon(index:Int)->MoonIcons
    {
        return MoonIcons.allValues[index]
    }
    
    class func IndexOfMoonIcon(icon:MoonIcons)->Int
    {
        if let index:Int = find(MoonIcons.allValues,icon)
        {
            return index
        }
        else
        {
            return -1
        }
    }
    
    class func GetUIImageFromIcoMoon(icon:MoonIcons, size:CGSize, highlight:Bool)->UIImage
    {
        // Create a context to render into.
        UIGraphicsBeginImageContext(size)
        
        // Work out where the origin of the drawn string should be to get it in
        // the centre of the image.
        let textOrigin:CGPoint = CGPointMake(5, 5)
        let tmpString:NSString = NSString(string: icon.rawValue)
        // Draw the string into out image!
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        if !highlight
        {
            let textFontAttributes: [String: AnyObject] = [
                NSFontAttributeName : UIFont(name: "icomoon", size: size.height-10)!,
                NSForegroundColorAttributeName : ControlBcgSolidColor,
                NSParagraphStyleAttributeName : style
            ]
            tmpString.drawAtPoint(textOrigin, withAttributes: textFontAttributes)
        }
        else
        {
            let textFontAttributes: [String: AnyObject] = [
                NSFontAttributeName : UIFont(name: "icomoon", size: size.height-10)!,
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSParagraphStyleAttributeName : style
            ]
            tmpString.drawAtPoint(textOrigin, withAttributes: textFontAttributes)
        }
        let retImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retImage
    }
    
    class func GetAttributedTextForIcon(iconAlignment:NSTextAlignment,iconSize:CGFloat,iconColor:UIColor,icon:String)->NSAttributedString
    {
        //Prepare Navigation Controller Item
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.alignment = iconAlignment
        let textFontAttributes: [String: AnyObject] = [
            NSFontAttributeName : UIFont(name: "icomoon", size: iconSize)!,
            NSForegroundColorAttributeName : iconColor,
            NSParagraphStyleAttributeName : style
        ]
        return NSAttributedString(string: icon , attributes: textFontAttributes)
    }
    
    //MARK: Storyboard helper
    class func getViewController(identifier:String!)->UIViewController?
    {
        // get your storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier) as? UIViewController
    }
    
    //MARK: BMI
    class func BMI(gender:Bool, height:Float, weight:Float, age:Int)->Float
    {
        //BMI = weight(kg)/height2(m2) (Metric Units)
        var inMeters = height / 100
        return weight/(inMeters*inMeters)
    }
    
    class func WeightForBMI(gender:Bool, height:Float, BMI:Float, age:Int)->Float
    {
        //BMI = weight(kg)/height2(m2) (Metric Units)
        var inMeters = height / 100
        return BMI * (inMeters*inMeters)
    }
    
    
    
    
}