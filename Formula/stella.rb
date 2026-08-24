# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.182 / @SHA_*@ placeholders below with
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
  version "0.9.182"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.182/stella-0.9.182-aarch64-apple-darwin.tar.gz"
      sha256 "79bfbebfe0f48e833990b1323f3e1b8415c5b4b40116c9fe01fc2353dd0155f9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.182/stella-0.9.182-x86_64-apple-darwin.tar.gz"
      sha256 "d5c97abf00b7b3ed52b19c8cc94a707b4fb24fdfda6f807904a8514c8e1af92a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.182/stella-0.9.182-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5904f2cc4238b9f0c37353b50b0af66e29ad67d3e23ed9209a547d0cfa98395d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.182/stella-0.9.182-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "851bb04dc4d626bacf28dbdc0c5154faf431e2e526a224b56ee1b3a7b8d978ed"
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
