# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.365 / @SHA_*@ placeholders below with
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
  version "0.9.365"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.365/stella-0.9.365-aarch64-apple-darwin.tar.gz"
      sha256 "d8fa04312cd1d062a517e59deab0b4775f0947c99a219a6846d7f4a096095193"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.365/stella-0.9.365-x86_64-apple-darwin.tar.gz"
      sha256 "d42dea0f14e7296c4066203c54eb2f5eeac7fa69e85ffdf8f77ab28c2da8a6ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.365/stella-0.9.365-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "54d4c3affb42997a2d8b60e139cfcdeffbd4312d26ab135b7378ced663c4ad1b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.365/stella-0.9.365-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87d10bf354b4b0b09587f0d8d839bb3e362ff4e5e1a55a3a6cdd3d9f91fd7892"
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
