# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.399 / @SHA_*@ placeholders below with
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
  version "0.9.399"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.399/stella-0.9.399-aarch64-apple-darwin.tar.gz"
      sha256 "21a67562234b551c50254e174e39de18dfabaf82e356c0c8883b5ec5bfb59022"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.399/stella-0.9.399-x86_64-apple-darwin.tar.gz"
      sha256 "529eb1fe793577f5482a112d6c0386ded1b8d982b7f47027cd9a9581977bbb7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.399/stella-0.9.399-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "83e4fce5c6e041bd7979332fa290f0dfb999aceb137d33fd10a34e6b4aa7751c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.399/stella-0.9.399-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fdfe5129880c294f875b63e9c12ae0c7f36c0b4f9e6785b4a8588faceb0f9846"
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
