# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.433 / @SHA_*@ placeholders below with
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
  version "0.9.433"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.433/stella-0.9.433-aarch64-apple-darwin.tar.gz"
      sha256 "70de706f2b5d70022bbf1334bece8a59b44956c7b8d9071aa3ca2c7eff971f9a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.433/stella-0.9.433-x86_64-apple-darwin.tar.gz"
      sha256 "85e264bc2940273c1e48eb8a263a484ef80238da62002b90182778bfce06322d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.433/stella-0.9.433-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ef1662eec6708312685ffc2776ef20924becabffd7bda41dbc1858ee689282e3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.433/stella-0.9.433-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "692252ee707662a22120fa57d9d56b48ce62bc570faf33b141749d058cea1f2c"
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
