{config, ...}: let
  containers = config.programs.zen-browser.profiles.default.containers;
  spaces = config.programs.zen-browser.profiles.default.spaces;
in {
  programs.zen-browser.profiles.default = {
    pinsForce = true;
    pinsForceAction = "demote";
    pins = rec {
      youtube = {
        title = "YouTube";
        id = "d4d74493-0801-4b60-ad15-d9adcc120db1";
        url = "https://www.youtube.com";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 0;
        isEssential = true;
      };

      github-developer = {
        title = "GitHub";
        id = "777a6f69-cdfb-43c4-b348-5ce733495556";
        url = "https://github.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1;
        isEssential = true;
      };

      chatgpt = {
        title = "ChatGPT";
        id = "71303e8b-3399-4c6a-a323-3ebd5c685824";
        url = "https://chatgpt.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1000;
      };

      gemini = {
        title = "Gemini";
        id = "06f6d673-f21e-42aa-97ac-9b3abd8b655d";
        url = "https://gemini.google.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1100;
      };

      notion = {
        title = "Notion";
        id = "534eed63-5da2-4806-837a-8a2f5cf7a263";
        url = "https://app.notion.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1200;
      };

      aws-console = {
        title = "AWS Console";
        id = "50e1088b-d981-4868-92b8-e9d4581fba0a";
        url = "https://console.aws.amazon.com/console/home/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1300;
      };

      homelab-folder = {
        title = "Homelab";
        id = "6c3e6aa6-6e5e-4226-8d21-23de209246af";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1400;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "🏠";
      };

      tailscale = {
        title = "Tailscale";
        id = "c36a74a1-a4db-42f2-ba28-b979dcbd19cc";
        url = "https://login.tailscale.com/admin/machines";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1410;
      };

      cloudflare = {
        title = "Cloudflare";
        id = "1487afb6-7050-4883-978c-a1735a3a74a6";
        url = "https://dash.cloudflare.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1420;
      };

      homepage = {
        title = "Homepage";
        id = "e742eea4-2fc3-4cdf-a168-f408f244500b";
        url = "https://home.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1430;
      };

      git-with-min = {
        title = "Git with Min!";
        id = "36aab7c0-4398-4d0a-a6ec-df4f99618d92";
        url = "https://git.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1440;
      };

      vaultwarden = {
        title = "Vaultwarden";
        id = "84c31b0a-e043-4899-8511-903d0a28f641";
        url = "https://vault.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1450;
      };

      uptime = {
        title = "Uptime";
        id = "9538e4dd-486c-4e6e-8e9c-19df2d12e38b";
        url = "https://status.ridewithmin.com/status";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1460;
      };

      grafana = {
        title = "Grafana";
        id = "03f8eb6f-2da9-41d8-b908-b0c3b66f43fd";
        url = "https://grafana.ridewithmin.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1470;
      };

      nix-folder = {
        title = "Nix";
        id = "1a16dcb7-aa4d-4c06-8efd-6719d9791483";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1500;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "❄️";
      };

      nixos-search = {
        title = "NixOS Search";
        id = "53ec9929-f070-4587-a280-e5cfc37882b7";
        url = "https://search.nixos.org/packages";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1510;
      };

      home-manager-search = {
        title = "Home Manager Search";
        id = "1fdbdcc2-ba02-4733-90c1-f1557e6e6dfb";
        url = "https://home-manager-options.extranix.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1520;
      };

      nix-dev = {
        title = "Nix.dev";
        id = "7e8cde9d-8336-41b7-8abf-719139b3f5c6";
        url = "https://nix.dev/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1530;
      };

      noogle = {
        title = "Noogle";
        id = "28b3c887-ef66-4b21-98bc-ca499d8860a9";
        url = "https://noogle.dev/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1540;
      };

      tossinvest = {
        title = "TossInvest";
        id = "f11b2c97-8867-4e95-9a17-e5fc8cdc8dfe";
        url = "https://www.tossinvest.com/";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2000;
      };

      investing = {
        title = "Investing.com";
        id = "5c313f11-e48a-4949-bb2b-6afaa5a535d7";
        url = "https://www.investing.com";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2100;
      };

      tradingview = {
        title = "TradingView";
        id = "b10e6f87-622e-43da-883c-d5d789f7423d";
        url = "https://www.tradingview.com/chart/FGyFZdhQ/?symbol=DEEPCOIN:ETHUSDT.P";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2200;
      };

      deepcoin = {
        title = "Deepcoin";
        id = "d2217bc7-bdb9-4d37-9fc2-2c66fcb4195e";
        url = "https://www.deepcoin.com/swap/en/ETHUSDT";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2300;
      };

      real-estate-folder = {
        title = "Real Estate";
        id = "ef2c4075-24a9-4b90-b4d7-4bc5ad0f6a9b";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2400;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "🏠";
      };

      naver-real-estate = {
        title = "네이버 부동산";
        id = "e75f7f72-4135-4bc5-ab39-f9f04f0995b2";
        url = "https://fin.land.naver.com/map";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2410;
      };

      lh-apply = {
        title = "LH청약";
        id = "fc5442a3-2ddd-4c98-a596-d0113e275d98";
        url = "https://apply.lh.or.kr/lhapply/apply/main.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2420;
      };

      sh-apply = {
        title = "SH청약";
        id = "9150937c-b9fa-42dc-aedd-c5bd2791b2fa";
        url = "https://www.i-sh.co.kr/app/index.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2430;
      };

      applyhome = {
        title = "청약홈";
        id = "e46ba570-22cd-49dd-b31d-f580f996a6e6";
        url = "https://www.applyhome.co.kr/co/coa/selectMainView.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2440;
      };

      ayoung-home = {
        title = "아영이네 홈페이지";
        id = "1490d3c1-18e7-4cce-940d-e8fb3602f3de";
        url = "https://www.ayounghome.com/";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2450;
      };

      ayoung-cafe = {
        title = "아영이네 카페";
        id = "a6ab76f6-edd7-41f3-a7c4-dfc3ab87a331";
        url = "https://cafe.naver.com/ayshh";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2460;
      };

      tving = {
        title = "TVing";
        id = "8134b0da-a809-465d-a0d6-940cb01759a2";
        url = "https://www.tving.com/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3000;
      };

      toeic = {
        title = "TOEIC";
        id = "796088ee-5021-44d8-ad5b-d84ceae3bb80";
        url = "https://exam.toeic.co.kr/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3100;
      };

      g-telp = {
        title = "G-TELP";
        id = "f80ca938-f605-48aa-87ab-7b2f4e7daacb";
        url = "https://www.g-telp.co.kr:335/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3200;
      };

      beside-global = {
        title = "비사이드글로벌";
        id = "bf54b3e5-e82a-44a5-9056-d001d01d4b19";
        url = "https://beside-global.daouoffice.com/home";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3300;
      };
    };
  };
}
