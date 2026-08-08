# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.27 / @SHA_*@ placeholders below with
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
  version "0.7.27"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.27/stella-0.7.27-aarch64-apple-darwin.tar.gz"
      sha256 "cb6fcb5c69d1ac872bf7569a6e46f807f08b9f312e53ae12cd23f7221c9dc87c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.27/stella-0.7.27-x86_64-apple-darwin.tar.gz"
      sha256 "4ad8dce69cb336fe6b304ff487f531e41139487a848bfb8a53853e67f77631c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.27/stella-0.7.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "83efcbab823930f4df89e0788d044c595c95474e4ed45a9003308cbd404e61b7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.27/stella-0.7.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "abf3f92f5390e3555235117f0b96ec1ce7fc1584cbb10a3450fd54b3182f5b81"
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
