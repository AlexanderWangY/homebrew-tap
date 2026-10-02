class Vx < Formula
  desc "Zero-config Linux VMs from the terminal: a CLI and dashboard on top of QEMU"
  homepage "https://github.com/AlexanderWangY/vx"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.1.0/vx-aarch64-apple-darwin.tar.xz"
      sha256 "881126e60ccee5cd2ea8065838e6f7f8743ce0914e20319cba84c3c4dc968e8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.1.0/vx-x86_64-apple-darwin.tar.xz"
      sha256 "9f319116b51c580701d13133eb71c22625d134f0ef56213250c5141cc586c8bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.1.0/vx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2d8722591016ecf4053f42b83e8c5a9fb91713987960caa447b25429bb130447"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.1.0/vx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "50dbcd050b6caad796f2afbed601b27b045c85551a73e33a696b46b8f47b6f8a"
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
