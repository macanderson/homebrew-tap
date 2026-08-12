# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.3 / @SHA_*@ placeholders below with
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
  version "0.9.3"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.3/stella-0.9.3-aarch64-apple-darwin.tar.gz"
      sha256 "c4dd2356da6c1e972daf376c6801bc180a302c417fee06addd312ddc1d7c213f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.3/stella-0.9.3-x86_64-apple-darwin.tar.gz"
      sha256 "96dc77b568b300347adbe5b864564d62894b5fd785631336a207e1452aeef717"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.3/stella-0.9.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "01573ecffe7f65609492cb3b3fafbec0e5b256ddd30d80a4386183c9380452a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.3/stella-0.9.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9131d1ccc51da0b6f2012e573fb7da6e0f61f8491b9109460c23feb79af9c8a6"
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
