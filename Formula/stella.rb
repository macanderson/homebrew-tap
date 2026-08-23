# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.168 / @SHA_*@ placeholders below with
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
  version "0.9.168"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.168/stella-0.9.168-aarch64-apple-darwin.tar.gz"
      sha256 "dfe6546d98c6f728f865508867dbf76c58d75284f335453c140c56e01e7a519b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.168/stella-0.9.168-x86_64-apple-darwin.tar.gz"
      sha256 "c7ccb8e316b4fe01e28cbd2f7d09488997a80fed52f7996473682a632a855a89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.168/stella-0.9.168-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "432eaff428398cc5d330d3f0e4961fc387d8ae8abe015311a2403ae6c05d9c43"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.168/stella-0.9.168-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8996a6c0028992e5d820016bf616eb10fff8addb8e4e881cf68269ea3193c01"
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
