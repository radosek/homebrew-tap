class Urban < Formula
  desc "Cyborg Project: 1999 side-scrolling action game, ported to Rust"
  homepage "https://github.com/radosek/urban-cyborg-project"
  url "https://github.com/radosek/urban-cyborg-project/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "38f5921a01dada8cad6e22f2df7082dbed442db5ec2d1727ab9a51ff5aa7c859"
  license "GPL-2.0-or-later"
  head "https://github.com/radosek/urban-cyborg-project.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    # SDL2 is built from source and linked statically; its CMakeLists predates CMake 4.
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"
    system "cargo", "install", *std_cargo_args(path: "rust")
  end

  def caveats
    <<~EOS
      URBAN needs the original 1999 game data (not included). Download
      URBAN-The-Cyborg-Project_DOS_EN.zip and copy urban.dat, levels.dat,
      intro.dat and the snd folder into:
        ~/Library/Application Support/urban/data
      Then run: urban
    EOS
  end

  test do
    assert_match "Urban v2.0.1", shell_output("#{bin}/urban -h")
  end
end
