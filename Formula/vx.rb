class Vx < Formula
  desc "Zero-config Linux VMs from the terminal: a CLI and dashboard on top of QEMU"
  homepage "https://github.com/AlexanderWangY/vx"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.3.0/vx-aarch64-apple-darwin.tar.xz"
      sha256 "4fa7e230220f13e831fa211ff91a3251800f101d7e25f8193d8937e95cfde45b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.3.0/vx-x86_64-apple-darwin.tar.xz"
      sha256 "d398084d82ffc96cf7fcb6aae3f72490e765c9d48a49edd51bcc796a188d9ee0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.3.0/vx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5a38924350b8b2eef93bfea398996b44416c173b839cdb1d7ade57d1e3717d28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.3.0/vx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29aba824714676068093b5a86ff2c2d24397f4e9ab36bdf0f4a8b00844af61cc"
    end
  end
  license "MIT"
  depends_on "qemu"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "vx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vx"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
