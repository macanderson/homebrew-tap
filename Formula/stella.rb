# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.14 / @SHA_*@ placeholders below with
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
  version "0.5.14"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.14/stella-0.5.14-aarch64-apple-darwin.tar.gz"
      sha256 "520764cb9eb12940d6a8618730f9636eb1c4a585b05ec6f03db44a4fda9ffbe6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.14/stella-0.5.14-x86_64-apple-darwin.tar.gz"
      sha256 "db42d698b4bc967a3e5a55095f5394e175110bdad6f88c6224bb2790626910e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.14/stella-0.5.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2a3296ebd3e32795df5e15de99fccdddfe86bdbfde08d827dee785c72a8003af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.14/stella-0.5.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9713a68dd79179011efb7393738d461d2d531cc02cca01cfb30d1147edd71814"
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
