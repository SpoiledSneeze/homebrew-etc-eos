cask "etc-eos-nomad" do
  version "3.3.2"
  sha256 :no_check

  url "https://www.etcconnect.com/WorkArea/DownloadAsset.aspx?id=10737519744"
  name "ETC Eos Family (ETCnomad)"
  desc "Lighting control software for theatrical and architectural applications"
  homepage "https://www.etcconnect.com/Eos-Software/"

  livecheck do
    url "https://www.etcconnect.com/Eos-Software/"
    strategy :page_match do |page|
      # Extract version and download URL from Mac software link
      # Pattern: <a href="/WorkArea/DownloadAsset.aspx?id=XXXXX">Eos ETCnomad Mac Software v3.3.2</a>
      match = page.match(%r{
        href="(/WorkArea/DownloadAsset\.aspx\?id=\d+)"[^>]*> # Capture Asset ID
        Eos\s+ETCnomad\s+Mac\s+Software\s+v                 # Match text
        (\d+\.\d+\.\d+)                                    # Capture Version
      }xi)
      
      if match
        # Return just the version - Homebrew will use this to detect updates
        # The URL with asset ID is in match[1] if needed for manual updates
        match[2]
      end
    end
  end

  # build number is hardcoded since it is impossible to retrieve via live check. 
  # however, https://www.etcconnect.com/WorkArea/DownloadAsset.aspx?id=XXXX returns a direct download link 
  # of a .pkg that contains the build number.
  pkg "ETCnomad Eos Mac #{version}.36.pkg"

  uninstall pkgutil: [
    "com.etc.eos.family.*",
    "com.etcconnect.pkg.ETCnomadEosMac",
    "com.etcconnect.pkg.EosFamilyDocuments",
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
        /Applications/Eos Family Welcome Screen.app

      Documentation and keyboard shortcuts can be found at:
        ~/Documents/ETC/Eos Family Documents/

      For the latest version information and downloads, visit:
        https://www.etcconnect.com/eos-software/

      Note: This cask installs Eos v3.x series. For legacy v2.9 support
      (required for older XP-based consoles), see 'etc-eos-nomad@2.9'
    EOS
  end
end
