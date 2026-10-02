class Vx < Formula
  desc "Zero-config Linux VMs from the terminal: a CLI and dashboard on top of QEMU"
  homepage "https://github.com/AlexanderWangY/vx"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.2.0/vx-aarch64-apple-darwin.tar.xz"
      sha256 "cb4823625d473818f59c7efc5b96187b0ee2789252ba1c2e6285f5f208ed3e1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.2.0/vx-x86_64-apple-darwin.tar.xz"
      sha256 "c6372c59c2eb72a2386f4f634e31759edc847eea3cec4b85adac16fcf5993666"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.2.0/vx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f674d6420361071b475f637f35a993b75b8edf53c9c33ac3420652f6d90b3bc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AlexanderWangY/vx/releases/download/v0.2.0/vx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff56f5b68eabf260eef650c9494e0cb941501d6cbadfee004d127bf96fcd5002"
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
