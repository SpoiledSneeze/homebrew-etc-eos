cask "etc-eos-nomad" do
  version "3.3.2.36"
  sha256 "707c7bd6e8cc41cb80092cfca1a728b63ce864356905576662adcab92ba29a32"

  url "https://www.etcconnect.com/WorkArea/DownloadAsset.aspx?id=10737519744"
  name "ETC Eos Family (ETCnomad)"
  desc "Lighting control software for theatrical and architectural applications"
  homepage "https://www.etcconnect.com/Products/Consoles/Eos-Family/ETCnomad-ETCnomad-Puck/"

  livecheck do
    url "https://www.etcconnect.com/Eos-Software/"
    strategy :page_match do |page|
      # Extract version and download URL from Mac software link
      # Pattern: <a href="/WorkArea/DownloadAsset.aspx?id=XXXXX">Eos ETCnomad Mac Software v3.3.2</a>
      match = page.match(%r{href="(/WorkArea/DownloadAsset\.aspx\?id=\d+)"[^>]*>Eos\s+ETCnomad\s+Mac\s+Software\s+v(\d+\.\d+\.\d+)}i)
      
      if match
        # Return just the version - Homebrew will use this to detect updates
        # The URL with asset ID is in match[1] if needed for manual updates
        match[2]
      end
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