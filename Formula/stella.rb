# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.199 / @SHA_*@ placeholders below with
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
  version "0.9.199"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.199/stella-0.9.199-aarch64-apple-darwin.tar.gz"
      sha256 "2cad1d4dd5e5a0f378a2282cf0279039f965ffad71bbdd1cee75b6ac56937607"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.199/stella-0.9.199-x86_64-apple-darwin.tar.gz"
      sha256 "51fcb49b8f41923ba57293ef0647879d3478cba023bed6bd154ed6f3ac272395"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.199/stella-0.9.199-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70eca843ea74655113df4e0d2184a63529ea29ffbb2e77eb0f40b2629e88ce85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.199/stella-0.9.199-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c205bc80002f42ea93641659891e78b0c961f28f8ad0e7b7dfcd879ce7571c06"
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
