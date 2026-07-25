# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.13 / @SHA_*@ placeholders below with
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
  version "0.5.13"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.13/stella-0.5.13-aarch64-apple-darwin.tar.gz"
      sha256 "c0a4698b7bb5460f07c7f3f214aeb619fbf5b5f6ceb2212db5afbdadfb79c4c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.13/stella-0.5.13-x86_64-apple-darwin.tar.gz"
      sha256 "fcd9f0bbaa1694e41b2b6b79c1ba900d7f6525f1c10cfc795059ec965b524312"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.13/stella-0.5.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eecbcfb2684ac72cbe406984353169f6ca40bffaba007052be0f169627bb106f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.13/stella-0.5.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f714ce4941663cb4471d24b6177526288dc017af0219362778c0c61b4176084"
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
