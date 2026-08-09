# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.3 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.8.3"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.3/stella-0.8.3-aarch64-apple-darwin.tar.gz"
      sha256 "6f1ae8b60642b7cdc1dfab8bfe079c708153766916b8e6aa55325bce189270ef"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.3/stella-0.8.3-x86_64-apple-darwin.tar.gz"
      sha256 "eaadb389a9b2aabf2fbf87d3e9c0b1ac065eb09d095272e11fe3e2fa34b8d4ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.3/stella-0.8.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7f92110ff112c8a950ba6bca17fe878744b06ea222bc53c28cca7ee4c8b1a769"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.3/stella-0.8.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7dba3c4f29d904766cabf2f71955ed20217369de0591ba3cc2f64676043f590c"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
