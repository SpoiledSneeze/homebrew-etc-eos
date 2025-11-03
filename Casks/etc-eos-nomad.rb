cask "etc-eos-nomad" do
  version "3.2.12"
  sha256 :no_check

  url "https://www.etcconnect.com/WorkArea/DownloadAsset.aspx?id=10737506112"
  name "ETC Eos Family (ETCnomad)"
  desc "Lighting control software for theatrical and architectural applications"
  homepage "https://www.etcconnect.com/Products/Consoles/Eos-Family/ETCnomad-ETCnomad-Puck/"

  livecheck do
    url "https://support.etcconnect.com/ETC/Consoles/Eos_Family/Software_and_Programming/All_Eos_Family_Software_Versions"
    strategy :page_match do |page|
      page.scan(/(\d+\.\d+\.\d+)/).flatten.select { |v| v.start_with?("3.") }.first
    end
  end

  pkg "ETCnomad_Eos_Mac_v#{version}.pkg"

  uninstall pkgutil: [
    "com.etcconnect.pkg.ETCnomadEosMac",
    "com.etcconnect.pkg.EosFamilyDocuments",
    "com.etc.eos.family.*",
  ]

  zap trash: [
    "~/Documents/ETC",
    "~/Library/Application Support/ETC",
    "~/Library/Preferences/com.etc.eos.*",
    "~/Library/Saved Application State/com.etc.eos.*",
  ]

  caveats do
    <<~EOS
      ETCnomad requires a USB hardware key (dongle) to function beyond demo mode.

      After installation, launch the application from:
        /Applications/Eos Family/Eos Configuration Utility

      Documentation and keyboard shortcuts can be found at:
        ~/Documents/ETC/Eos Family Documents/

      For the latest version information and downloads, visit:
        https://www.etcconnect.com/eos-software/

      Note: This cask installs Eos v3.x series. For legacy v2.9 support
      (required for older XP-based consoles), see 'etc-eos-nomad@2.9'
    EOS
  end
end