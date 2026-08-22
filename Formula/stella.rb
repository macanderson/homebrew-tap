# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.127 / @SHA_*@ placeholders below with
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
  version "0.9.127"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.127/stella-0.9.127-aarch64-apple-darwin.tar.gz"
      sha256 "80af2fb72c2efc8cd7e5638dac18987fb1cb0650f37cc929ace06f83d366a11a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.127/stella-0.9.127-x86_64-apple-darwin.tar.gz"
      sha256 "f9a744170d8629d541eaa531df1c00b1084e2849650b3fce517f145c4a6aa1f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.127/stella-0.9.127-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "756429c76d949ca97ba254dc3ad16d5f1c201fa7766664d845098eb3a6335ed7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.127/stella-0.9.127-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25e73c7ce49f0eecf33258272b27f4cc0ab6d810256267d09a99148fd278f770"
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
