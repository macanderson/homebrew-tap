# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.225 / @SHA_*@ placeholders below with
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
  version "0.9.225"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.225/stella-0.9.225-aarch64-apple-darwin.tar.gz"
      sha256 "ea1e2336c24e00a9ea45f94512d233216aca3421af920d3a06b9014320b4bbe2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.225/stella-0.9.225-x86_64-apple-darwin.tar.gz"
      sha256 "521a96ad2bae46fa867eb5301c0d6c6946e691b205132a594e7af4acf33558af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.225/stella-0.9.225-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ff897705fef6712fd11820b1bad83d5d9da4374e3f70f494bbb26f363cae743"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.225/stella-0.9.225-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9891c2af470d1001a03460a6fcaf3f8ba4a92cb7589cd59481149e8decbfe457"
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
